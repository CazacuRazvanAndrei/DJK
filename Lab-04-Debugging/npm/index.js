const express = require('express');
const app = express();
const hobbies = [
    'Swimming', 'Diving', 'Jogging', 'Cooking', 'Singing'
  ];
  

app.listen(3000, '0.0.0.0', ()=>{
    console.log('Application listening at 0.0.0.0:3000');
})

app.get('/', (req,res)=>{
    res.send('Sample Application: Hello World!');
})
  app.get('/hobbies', (req,res)=>{
    res.send(hobbies);
  })