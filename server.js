var express = require('express');
var app = express(); 
var port = process.env.PORT || 3050; 

 app.get('/', (req, res) => {
    console.log(req)
    res.json({"ms": "hn-ms-1"})
 }) 

app.listen(port, 
    function(){ 
        console.log('Server started on port: ' + port); 
});