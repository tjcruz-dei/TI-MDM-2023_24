/**
 * Tecnologias de Interface, Winter 2023
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Serial communication with javascript and arduino (using HTTP methods)
 *
 * @authors: Sérgio M. Rebelo, Ana Cláudia Rodrigues, and Tiago Cruz
 * @since:   27–04–2023
 */

const { SerialPort } = require('serialport');
const { ReadlineParser } = require('@serialport/parser-readline')

const express = require('express');
const app = express();

let port, parser;

let status = [0,0];


// serve static files
app.use(express.static('public'))

const listener = app.listen(8000, async () => {
    console.info(`application running at port ${listener.address().port}`);

    // list available ports
    const availablePorts = await SerialPort.list();
    // print the available ports
    console.info (availablePorts);

    port = new SerialPort({
        path: availablePorts[3].path,
        baudRate: 9600,
    });

    parser = port.pipe(new ReadlineParser({delimiter: '\r\n',  encoding: 'ascii'}));


    // function that runs when the port is open
    port.on (`open`, () => {
        console.info(`serial communication established (baudRate:${port.baudRate}, path:${port.path}, port:${JSON.stringify(port.port.fd)}, isOpen:${port.isOpen})`);
    });

    // function to read the content (without parser)
    // port.on(`readable`, () => {
    //    console.log('read:', port.read());
    // });

    // function to read the content (with parser)
    parser.on('data', (rx) => {
        // console.log('Rx=', rx);
        let data = rx.split(":");
        if (data.length > 1 && data[0] === `s` ) {
            const values = data[1].split(`|`);

            for (let i in values) {
                status[i] = parseInt(values[i]);
            }
        }
        console.info(`current status=${status}`);
    });
});

// get request to write on port
app.get('/write/:msg', async (req, res) => {
    const data = req.params.msg;

    await port.write(data, (err) => {
        if (err) {
            res.status(404).send({msg: 'Not found'});
            return console.log(`Error on write: ${err.message}`);
        }
        console.info(`message written: ${data}`);
        res.send({msg: data, data: undefined});
    });

    // Open errors will be emitted as an error event
    port.on('error', (err) => {
        res.status(404).send({msg: 'Not found'});
        console.log(`Error: ${err}`);
    });
});


app.get(`/status`, async (req, res) => {
    res.send({msg: "arduino current status", data: status});
});

