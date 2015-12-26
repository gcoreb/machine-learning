var http = require('http');

var express = require('express');
var app = express();
var exec = require('child_process').exec;



    app.use(express.static(__dirname));



app.get('/', function(req, res) {

    res.writeHead(200, {'Content-Type': 'text/html'});

    res.write('<h1 style="font:arial">Machine learning</h1><hr>');

    process.env.R_WEB_DIR = process.cwd();

    var child = exec('Rscript init.R', function(error, stdout, stderr) {

        console.log('stderr: ' + stderr);

        if (error !== null) {

            console.log('exec error: ' + error);

        }
        res.write('<h5 style="font: arial">Generated 100 points. It took <span style="color:blue">'+ stdout + ' </span>iterations to generate the hypothesis g. Ran 1,000 iterations.</h5> <button onclick="location.reload();">Run again</button>')
        res.write('<img src="/init.png"/>');

        res.end(':)');

    });

});
var server = http.createServer(app);

server.listen(process.env.PORT || 5000);

console.log('Server running at http://127.0.0.1:1337/');