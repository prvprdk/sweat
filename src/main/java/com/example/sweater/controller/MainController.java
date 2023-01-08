package com.example.sweater.controller;

import com.example.sweater.domain.Message;
import com.example.sweater.domain.User;
import com.example.sweater.domain.dto.MessageDto;
import com.example.sweater.repository.MessageRepository;
import com.example.sweater.service.MessageService;
import com.example.sweater.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.data.web.PageableDefault;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.util.UriComponents;
import org.springframework.web.util.UriComponentsBuilder;

import javax.validation.Valid;
import java.io.File;
import java.io.IOException;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

@Controller
public class MainController {

    @Autowired
    private MessageRepository messageRepository;
    @Autowired
    private UserService userService;
    @Value("${upload.path}")
    private  String uploadPath;
    @Autowired
    private MessageService messageService;

    @GetMapping("/")
    public String greeting(Map<String,Object> model) {
        return "greeting";
    }

    @GetMapping ("/main")
    public String main(@RequestParam(required = false) String filter,
                       Model model,
                       @PageableDefault(sort = {"id"},direction = Sort.Direction.DESC) Pageable pageable,
                       @AuthenticationPrincipal User user){

        Page<MessageDto> page = messageService.messageList(pageable,filter, user);

        model.addAttribute("page", page);
        model.addAttribute("url", "/main");
        model.addAttribute("filter", filter);
        return  "main";
    }

    @PostMapping ("/main")
    public  String add (
            @AuthenticationPrincipal User user,
            @Valid Message message,
            BindingResult bindingResult,
            Model model,
            @RequestParam ("file") MultipartFile file
           ) throws IOException {

        message.setAuthor(user);
        if(bindingResult.hasErrors()) {
           Map <String, String> errorsMap = ControllerUtils.getErrors(bindingResult);
           model.mergeAttributes(errorsMap);
           model.addAttribute("message", message);
        }else{
            saveFile(message, file);
            model.addAttribute("message", null);
            messageRepository.save(message);
        }
            return "redirect:/main";
        }

    private void saveFile(Message message, MultipartFile file) throws IOException {
        if (!file.isEmpty()) {

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdir();
            }
            String uuidFile = UUID.randomUUID().toString();
            String resultFilename = uuidFile + "." + file.getOriginalFilename();
            file.transferTo(new File(uploadPath + "/" + resultFilename));
            message.setFilename(resultFilename);
        }
    }

    @GetMapping ("/user-messages/{author}")
    public String userMessages (
            @AuthenticationPrincipal User currentUser,
            @PathVariable User author,
            @RequestParam (required = false) Message message,
            @PageableDefault(sort = {"id"},direction = Sort.Direction.DESC) Pageable pageable,
            Model model
    ){
        Page< MessageDto> page = messageService.messageListForUser(pageable, currentUser, author);
        model.addAttribute("userChannel", author);
        model.addAttribute("subscriptionsCount", author.getSubscriptions().size());
        model.addAttribute("subscriberCount", author.getSubscriber().size());
        model.addAttribute("isSubscriber", author.getSubscriber().contains(currentUser));
        model.addAttribute("page", page);
        model.addAttribute("message", message);
        model.addAttribute("isCurrentUser", currentUser.equals(author));
        model.addAttribute("url", "/user-message/" + author.getId());

        return "userMessages";
    }


    @PostMapping ("/user-messages/{user}")
    public  String updateMessage (
            @AuthenticationPrincipal User currentUser,
            @PathVariable Long user,
            @RequestParam ("id") Message message,
            @RequestParam ("text") String text,
            @RequestParam ("tag") String tag,
            @RequestParam ("file") MultipartFile file) throws IOException {

        if (message.getAuthor().equals(currentUser)){
            if (!StringUtils.isEmpty(text)){
                message.setTag(text);
            }
            if (!StringUtils.isEmpty(tag)){
                message.setTag(tag);
            }
            saveFile(message,file);
            messageRepository.save(message);
        }
        return "redirect:/user-messages/" + user;
    }

    @GetMapping ("/user/subscribe/{user}")
    public String subscribe (
            @PathVariable User user,
            @AuthenticationPrincipal User currentUser,
            Model model
    ){
        userService.subscribe(currentUser, user);
        return "redirect:/user-messages/" + user.getId();
    }

    @GetMapping ("/user/unsubscribe/{user}")
    public String unsubscribe (
            @PathVariable User user,
            @AuthenticationPrincipal User currentUser,
            Model model
    ){
        userService.unsubscribe(currentUser, user);
        return "redirect:/user-messages/" + user.getId();
    }

    @GetMapping ("/user/{type}/{user}/list")
    public String userList (
            @PathVariable User user,
            @PathVariable String type,
            Model model){

        model.addAttribute("userChannel", user);
        model.addAttribute("type",type );

        if ("subscriptions".equals(type)){
            model.addAttribute("users", user.getSubscriptions());
        }else {
            model.addAttribute("users", user.getSubscriber());
        }
        return "subscriptions";
    }

    @GetMapping ("/messages/{message}/like")
    public String like(@AuthenticationPrincipal User currentUser,
                       @PathVariable Message message,
                       RedirectAttributes redirectAttributes,
                       @RequestHeader(required = false) String referer){
        Set<User> likes = message.getLikes();
        if (likes.contains(currentUser)){
            likes.remove(currentUser);
        }else {
            likes.add(currentUser);
        }
        messageRepository.save(message);
        UriComponents components = UriComponentsBuilder.fromHttpUrl(referer).build();
        components.getQueryParams()
                .entrySet()
                .forEach(pair->redirectAttributes.addAttribute(pair.getKey(), pair.getValue()));
        return "redirect:" + components.getPath();
    }

}