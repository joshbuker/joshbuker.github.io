---
title: Tank Robot Prototype Retrospective
description: Reviewing the Tank Robot I created, and my next steps in learning about robotics.
categories:
  - Journaling
  - Projects
tags:
  - Robotics
  - Engineering
---

Outline:
- What is the tank bot, and what was my goal with it?
  - Learning electrical engineering / how to wire up the battery to the other stuff. simplest use-case
- First iteration w/ Arduino uno & manual control
- Second iteration w/ Pixhawk & both autonomous and manual control

This blog post is a bit belated, as the actual robots I made were about three years ago at this point. I had always meant to do a project writeup, but life got away from me and it wasn't until now that I've had the opportunity to get around to compiling a project retrospective.

There were two iterations of the Tank Robot so far, although I may revisit it one last time before applying my learnings to more complicated robots like the reaction wheel bike that I've been wanting to tackle for a while. The first version was a very simple bot, intended to help bridge my knowledge with very simple electrical concepts by following the 80/20 rule for learning new material. It used an Arduino Uno as the control unit, and was a purely manual control robot.

{%
  include embed/video.html
  src='/assets/video/tank.mp4'
  title='Tank Robot Manual Driving Demo'
  loop=true
%}

The second iteration of the robot was actually in the middle of working on a boat robot with Keith Matthews, and was more about proving that the techniques we were using for the boat robot could be translated to ground based vehicles as well.

{%
  include embed/video.html
  src='/assets/video/tank_autonomous_mission.mp4'
  title='Tank Robot Autonomous Mission Demo'
%}
