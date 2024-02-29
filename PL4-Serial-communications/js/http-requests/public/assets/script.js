/**
 * Projeto 4, Winter/Springer 2023
 * Universidade de Coimbra
 *
 * Serial Communication via Arduino and Javascript (using GET Requests)
 * Client Side
 *
 * @authors: Sérgio M. Rebelo and Jéssica Parente
 * @since:   25–03–2023
 */

// current state of first led
let current = [-1, -1];

window.onload = () => {
    const interval = setInterval(() => {
        const data = fetch(`/status`)
            .then((response) => response.json())
            .then((data) => {
                current = data.data;
                const circles = document.querySelectorAll(`.circle`);
                circles.forEach( (c, i) => {
                    if (current[i] === 1 && !c.classList.contains(`active`)) {
                       c.classList.add(`active`);
                    } else if (current[i] !== 1 && c.classList.contains(`active`)){
                        c.classList.remove(`active`);
                    }
                });
            })
            .catch((err) => console.warn(`not possible to read arduino status: ${err}`))
    }, 100);

    document.getElementById(`toggleBt`).onclick = invert;
}

const invert = () => {
    const msg = current[0] === 1 ? `L` : `H`;
    const req = fetch(`/write/${msg}`);
}