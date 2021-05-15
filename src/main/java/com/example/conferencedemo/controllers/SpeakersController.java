package com.example.conferencedemo.controllers;

import com.example.conferencedemo.models.Session;
import com.example.conferencedemo.models.Speaker;
import com.example.conferencedemo.repositories.SpeakerRepository;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/v1/speakers")
public class SpeakersController {
    @Autowired
    private SpeakerRepository speakerRepository;

    @GetMapping
    public List<Speaker> list(){
        return speakerRepository.findAll();
    }

    @GetMapping
    @RequestMapping("{id}")
    public Speaker get(@PathVariable Long id){
        return speakerRepository.getOne(id);
    }

    @PostMapping
//    @ResponseStatus(HttpStatus.CREATED)
    public Speaker create(@RequestBody final Speaker speaker){
        return speakerRepository.saveAndFlush(speaker);
    }

    @RequestMapping(value = "{id}", method=RequestMethod.DELETE)
    public void delete(@PathVariable Long id){
        //Also need to check that the children records are deleted before deleting parent
        speakerRepository.deleteById(id);
    }

    @RequestMapping(value = "{id}", method = RequestMethod.PUT)
    public Speaker update(@PathVariable Long id, @RequestBody Session session){
        Speaker existingSpeaker = speakerRepository.getOne(id);
        BeanUtils.copyProperties(session, existingSpeaker, "speaker_id");

        return speakerRepository.saveAndFlush(existingSpeaker);
    }
}
