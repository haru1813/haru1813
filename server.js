const express = require('express');
const { exec } = require('child_process');
const fs = require('fs');
const app = express();
const port = 9999;

app.use(express.json());
app.use(express.static('.'));

// Git 명령어 실행을 위한 엔드포인트
app.post('/execute', (req, res) => {
    const { command } = req.body;
    exec(command, (error, stdout, stderr) => {
        if (error) {
            console.error(`Error: ${error}`);
            return res.status(500).send(error.message);
        }
        res.send(stdout || stderr);
    });
});

// memo.txt 파일 쓰기를 위한 엔드포인트
app.post('/memo.txt', express.text(), (req, res) => {
    fs.appendFile('memo.txt', req.body, (err) => {
        if (err) {
            console.error('Error writing to memo.txt:', err);
            return res.status(500).send('Error writing to file');
        }
        res.send('Success');
    });
});

app.listen(port, () => {
    console.log(`Server running at http://localhost:${port}`);
}); 