# LA Hacks 2019: Leaf
More on Devpost: https://devpost.com/software/chicknskratch

## Inspiration
In order to let people **protect** environment,  you should let them **care** about environment first. _Leaf_ is an application that use virtual reward and competition to drive people to learn more knowledge about plant near them. In this way, people can have more passion to protect their green neighborhood. Our idea is inspired by Pokemon Go and other social media. 
## What it does
_Leaf_ is a **social** app that uses **daily task** and **competition** between friends to encourage our users to learn more about the plants nearby them. After entering their daily path, our users will receive a task called **Today's Green**. This task will randomly pick plant nearby user as the riddle. The user needs to follow the hints provided by _Leaf_ to find this plant. To see if they find the right plant, the user can use the camera inside _Leaf_ to take a photo of the plant. If the user finds the correct plant, the plant will be added to user's collection and user will gain points. The user with  **the most points** will show up at the front page of the application. If the user didn't find the right plants, more hints will be released with time passing.  
## How we built it
The fundamental code of _Leaf_ is built on Xcode. Most codes, UI and algorithms are created on Xcode. They include time count down and ranking between users. We created icons and some interface elements on Paint 3D. The flower recognition function is based on a Core ML model originally made by Maria-Elena Nilsback and Andrew Zisserman of Oxford University. Our team link it with the cell phone camera and create an algorithm that process image resolution. 
## Challenges we ran into
Most of our team members have little experience with mobile software development and relevant UI design. We have to spend lost of time to get familiar with the Xcode and design our interface from scratch. Also, there are little resources about flower classification program. We need to do lots of adjustments to coordinate the model online with our application. 
## Accomplishments that we're proud of
We have designed our unique **User Interface**. Also, the operating of the application is very smooth and the **flower recognition** has a good success rate. 
## What we learned
Every member gained knowledge about Xcode program and ios structure. In addition, we have learned some basic UI design principle. 
## What's next for Leaf
The next goal for _leaf_ is to create a database store the distribution of plants in UCLA region and enhance our path creation system. With the completion of this step, our application can provide more mature and accurate customized daily task. We also wish to build a connection to environmental groups to protect green in real life.  
