const initialFlights = [
    {
        time: "15:05",
        flight: "NH 0175",
        dest: "Tokyo",
        gate: "D02",
        status: "ON TIME"
    },
    {
        time: "15:15",
        flight: "WN 0612",
        dest: "Las Vegas",
        gate: "B09",
        status: "BOARDING"
    },
    {
        time: "12:59",
        flight: "F9 1635",
        dest: "Boston",
        gate: "B05",
        status: "GATE CLOSED"
    },
    {
        time: "13:37",
        flight: "BA 1760",
        dest: "San Francisco",
        gate: "B20",
        status: "DELAYED"
    },
    {
        time: "14:30",
        flight: "CA 3156",
        dest: "New York",
        gate: "B20",
        status: "DEPARTED"
    }
];

const destinations = [
    "London",
    "Tokyo",
    "Dubai",
    "Paris",
    "Singapore",
    "Mumbai",
    "Sydney",
    "New York"
];

const statusFlow = [
    "ON TIME",
    "BOARDING",
    "GATE CLOSED",
    "DEPARTED"
];

let flights = [...initialFlights];

const board = document.getElementById("board");
const addDepartureBtn = document.getElementById("addDepartureBtn");
const resetBtn = document.getElementById("resetBtn");
const summaryText = document.getElementById("summaryText");

const clock = document.getElementById("clock");

function getStatusClass(status)
{
    if(status === "ON TIME")
    {
        return "status-ontime";
    }

    if(status === "BOARDING")
    {
        return "status-boarding";
    }

    if(status === "DELAYED")
    {
        return "status-delayed";
    }

    if(status === "GATE CLOSED")
    {
        return "status-gateclosed";
    }

    return "status-departed";
}

function createFlightRow(flight)
{
    const row = document.createElement("div");
    row.className = "flight-row";

    const time = document.createElement("div");
    time.textContent = flight.time;
    time.className="time-box";

    const flightNo = document.createElement("div");
    flightNo.textContent = flight.flight;
    flightNo.className="flight-box";

    const destination = document.createElement("div");
    destination.textContent = flight.dest;
    destination.className="dest-box";

    const gate = document.createElement("div");
    gate.textContent = flight.gate;
    gate.className="gate-box";

    const status = document.createElement("div");
    status.textContent = flight.status;


    status.className = `status-cell ${getStatusClass(flight.status)}`;

    flight.statusElement = status;

    row.appendChild(time);
    row.appendChild(flightNo);
    row.appendChild(destination);
    row.appendChild(gate);
    row.appendChild(status);

    return row;
}
function renderBoard(){
    board.innerHTML="";
    flights.forEach(function(flight){
        const row=createFlightRow(flight);
        board.appendChild(row);
    });
    updateSummary();
}

renderBoard();

function updateClock()
{
    const now = new Date();

    const time = now.toLocaleTimeString("en-GB", {
        hour12: false
    });

    clock.textContent = time;
}

updateClock();
setInterval(updateClock,1000);

function addDeparture()
{
    const newFlight =
    {
        time: `${Math.floor(Math.random()*24)
            .toString()
            .padStart(2,"0")}:${Math.floor(Math.random()*60)
            .toString()
            .padStart(2,"0")}`,

        flight: `AI ${Math.floor(Math.random()*9000)+1000}`,

        dest: destinations[
            Math.floor(Math.random()*destinations.length)
        ],

        gate: `A${Math.floor(Math.random()*20)+1}`,

        status: "ON TIME"
    };

    flights.push(newFlight);

    renderBoard();

    updateSummary();
}

addDepartureBtn.addEventListener(
    "click",
    addDeparture
);

function resetBoard()
{
    flights = [...initialFlights];

    renderBoard();

    updateSummary();
}

resetBtn.addEventListener(
    "click",
    resetBoard
);

function updateSummary()
{
    const total = flights.length;

    const boarding = flights.filter(function(flight)
    {
        return flight.status === "BOARDING";
    }).length;

    const delayed = flights.filter(function(flight)
    {
        return flight.status === "DELAYED";
    }).length;

    summaryText.textContent =
        `${total} departures · ${boarding} boarding · ${delayed} delayed`;
}

function updateFlightStatus()
{
    if (flights.length === 0)
    {
        return;
    }

    const activeFlights = flights.filter(function(flight)
    {
        return flight.status !== "DEPARTED";
    });

    if (activeFlights.length === 0)
    {
        return;
    }

    const randomIndex =
        Math.floor(Math.random() * activeFlights.length);

    const flight = activeFlights[randomIndex];

    const currentIndex =
        statusFlow.indexOf(flight.status);

    if (currentIndex < statusFlow.length - 1)
    {
        const nextStatus =
            statusFlow[currentIndex + 1];

        flight.status = nextStatus;

        flight.statusElement.classList.add("status-flip");

        setTimeout(() => {

            flight.statusElement.textContent = nextStatus;

            flight.statusElement.className =
                `status-cell ${getStatusClass(nextStatus)}`;

        },300);

        setTimeout(() => {

            flight.statusElement.classList.remove("status-flip");

},600);
        setTimeout(function ()
        {
            flight.statusElement.classList.remove("status-updated");
        }, 400);

        updateSummary();
    }
}
setInterval(
    updateFlightStatus,
    5000
);


function cycleFlights()
{
    const firstRow = board.firstElementChild;

        if(firstRow)
        {
            firstRow.classList.add("removing");

            setTimeout(() => {

                flights.shift();

                addNewFlight();

                renderBoard();

            },500);
        }

    const newFlight =
    {
        time: `${Math.floor(Math.random()*24)
        .toString()
        .padStart(2,"0")}:${Math.floor(Math.random()*60)
        .toString()
        .padStart(2,"0")}`,

        flight: `AI ${Math.floor(Math.random()*9000)+1000}`,

        dest: destinations[
            Math.floor(Math.random()*destinations.length)
        ],

        gate: `A${Math.floor(Math.random()*20)+1}`,

        status: "ON TIME"
    };

    flights.push(newFlight);

    renderBoard();
}


setInterval(cycleFlights,10000);