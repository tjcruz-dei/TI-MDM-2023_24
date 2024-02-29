/**
 * Tecnologias de Interface, Winter 2023
 * Universidade de Coimbra
 * MSc in Design and Multimedia
 *
 * Serial Communication via Arduino and P5Js (using P5.Serial library)
 * First students should run p5.serialserver (node node_modules/p5.serialserver/startserver.js)
 *
 * @authors: Sérgio M. Rebelo, Ana Cláudia Rodrigues, and Tiago Cruz
 * @since:   27–04–2023
 */

let serial;
const circles = [];

setup = () => {
    background(245);
    createCanvas(windowWidth, windowHeight);

    // init serial communication
    serial = new p5.SerialPort();
    serial.openPort(`/dev/cu.usbmodem1101`);

    // print version of p5.serialport library
    console.info('p5.serialport.js ' + serial.version);

    // when connected
    serial.on('connected', () => {
        console.info(`connection between Arduino and P5.js established`);
    });

    // when we get a list of serial ports that are available
    serial.on('list', (list) => {
        // console.log(list);
    });

    // When our serial port is opened and ready for read/write
    serial.on('open', () => {
        console.info(`serial port ready`);
    });

    serial.on('<data>', update);

    circles.push(new Circle(width / 2 - 100, height / 2, 100, false));
    circles.push(new Circle(width / 2 + 100, height / 2, 100, false))

}

draw = () => {
    background(245);

    for (let circle of circles) {
        circle.draw();
    }
}

mousePressed = () => {
    // write to serial port when mouse Pressed inside of canvas
    const msg = circles[0].state === 1 ? `L` : `H`;
    serial.write(msg)

}

update = () => {
    // read the data on serial port
    const rawData = serial.readLine();
    let data = rawData.split(`:`);

    if (data.length > 1 && data[0] === `s`) {
        const values = data[1].split(`|`).map((v) => parseInt(v));
        for (let i in circles) {
            const circle = circles[i];
            circle.state = values[i];
        }
    }
}

class Circle {
    constructor(x, y, d, state) {
        this.pos = createVector(x, y);
        this.y = y;
        this.d = d;
        this.state = state;
    }

    draw() {
        push();
        noStroke();
        const c = this.state ? color(0, 255, 0) : color(0);
        fill(c);
        ellipse(this.pos.x, this.pos.y, this.d, this.d);
        pop();
    }

    hover(vec) {
        return this.pos.dist(vec) < this.d / 2
    }
}