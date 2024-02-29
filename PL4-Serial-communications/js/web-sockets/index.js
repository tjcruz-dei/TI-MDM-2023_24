/*
 * Tecnologias de Interface, Winter 2023
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Serial communication with javascript and arduino (using web sockets)
 *
 * @authors: Sérgio M. Rebelo, Ana Cláudia Rodrigues, and Tiago Cruz
 * @since:   27–04–2023
 */

const { SerialPort } = require('serialport');
const { ReadlineParser } = require('@serialport/parser-readline')

const express = require('express');
const app = express();
const http = require('http');
const server = http.createServer(app);

const { Server } = require("socket.io");
const io = new Server(server);

let port, parser;

app.use(express.static('public'));

io.on('connection', (socket) => {
    console.log(`a client connected at ${socket.id}`);

    socket.emit(`hello`, `hello!`)

    // write to arduino data
    socket.on(`write`, async (tx) => {
        await port.write(tx, (err) => {
            if (err) { return console.log(`Error on write: ${tx}`); }
        });
    });

    // error on connection
    socket.on(`error`, (err) => {
        socket.disconnect();
    });

    // emit the arduino status to data
    parser.on('data', (rx) => {
        socket.emit("status", rx);
    });

});


server.listen(8000, async () => {
    // open serial communication channel
    console.log('listening on port 8000');

    const availablePorts = await SerialPort.list();

    port = new SerialPort({
        path: availablePorts[3].path,
        baudRate: 9600,
    });

    parser = port.pipe(new ReadlineParser({delimiter: '\r\n',  encoding: 'ascii'}));

    port.on (`open`, () => {
        console.info(`serial communication established (baudRate:${port.baudRate}, path:${port.path}, port:${JSON.stringify(port.port.fd)}, isOpen:${port.isOpen})`);
    });
});
