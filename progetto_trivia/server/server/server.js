const { json } = require('express');
const express = require('express');

const app = express();
const PORT = 3000;

app.get('/domande', (req, res) => {

    const request = require('request');

    let url = "https://opentdb.com/api.php?amount=10&difficulty=medium&type=boolean";

    let options = { json: true };
    request(url, options, (error, result, body) => {


        if (error) {
            return console.log(error)
        };

        if (!error && res.statusCode == 200) {
            res.send(body);
        };
    });
});

app.listen(PORT, () => {
    console.log('server in ascolto alla porta ' + PORT);
});