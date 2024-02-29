/**
 * Projeto 4, Winter/Springer 2023
 * Universidade de Coimbra
 *
 * Serial Communication via Arduino and Javascript (using web sockets)
 * Client Side
 *
 * @authors: Sérgio M. Rebelo and Jéssica Parente
 * @since:   25–03–2023
 */

let socket;
let current = [-1, -1];
let id = -1;


window.onload = () => {

    socket = io();

    socket.on(`connect`, () => {
        id = socket.id;
        console.log(`connected at ${id}`);
    });

    socket.on(`disconnect`, () => {
        console.log(`disconnect from ${id}`);
    });

    socket.on(`status`, (e) => {
        let data = e.split(`:`);
        if (data.length > 1 && data[0] === `s`) {
            data = data[1].split(`|`).map((v) => parseInt(v));
            current = data;

            const circles = document.querySelectorAll(`.circle`);
            circles.forEach((c, i) => {
                if (current[i] === 1 && !c.classList.contains(`active`)) {
                    c.classList.add(`active`);
                } else if (current[i] !== 1 && c.classList.contains(`active`)) {
                    c.classList.remove(`active`);
                }
            });
        }
    });

    const invert = () => {
        const msg = current[0] === 1 ? `L` : `H`;
        socket.emit(`write`, msg);
        console.log(`write on socket=${msg}`);
    }

    document.getElementById(`toggleBt`).onclick = invert;
}



window.onbeforeunload = async (e) => {
    // close socket
    await socket.disconnect();
};


