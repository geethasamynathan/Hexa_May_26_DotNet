//--------------------------------------------------
// Initial Flight Data
//--------------------------------------------------

const originalFlights = [

{
time:"09:30",
flight:"AI101",
dest:"Delhi",
gate:"A1",
status:"ON TIME"
},

{
time:"10:15",
flight:"6E220",
dest:"Mumbai",
gate:"B2",
status:"BOARDING"
},

{
time:"11:00",
flight:"SG310",
dest:"Chennai",
gate:"C3",
status:"DELAYED"
},

{
time:"11:45",
flight:"UK550",
dest:"Bangalore",
gate:"D1",
status:"ON TIME"
}

];

// Copy for working
let flights = JSON.parse(JSON.stringify(originalFlights));

const board = document.getElementById("board");
const summary = document.getElementById("summary");

//--------------------------------------------------
// Build One Row
//--------------------------------------------------

function createRow(flight,index){

    // Create row
    const row=document.createElement("div");

    row.className="row";

    // Time
    const time=document.createElement("div");
    time.textContent=flight.time;

    // Flight
    const flightNo=document.createElement("div");
    flightNo.textContent=flight.flight;

    // Destination
    const dest=document.createElement("div");
    dest.textContent=flight.dest;

    // Gate
    const gate=document.createElement("div");
    gate.textContent=flight.gate;

    // Status
    const status=document.createElement("div");
    status.textContent=flight.status;

    status.id="status-"+index;

    setStatusColor(status,flight.status);

    // Attach cells

    row.appendChild(time);
    row.appendChild(flightNo);
    row.appendChild(dest);
    row.appendChild(gate);
    row.appendChild(status);

    // Attach row

    board.appendChild(row);

}

//--------------------------------------------------
// Render Board
//--------------------------------------------------

function renderBoard(){

    board.textContent="";

    flights.forEach((flight,index)=>{

        createRow(flight,index);

    });

    updateSummary();

}

//--------------------------------------------------
// Status Colors
//--------------------------------------------------

function setStatusColor(cell,status){

    cell.className="";

    switch(status){

        case "ON TIME":
            cell.classList.add("on-time");
            break;

        case "BOARDING":
            cell.classList.add("boarding");
            break;

        case "DELAYED":
            cell.classList.add("delayed");
            break;

        case "GATE CLOSED":
            cell.classList.add("closed");
            break;

        case "DEPARTED":
            cell.classList.add("departed");
            break;

    }

}

//--------------------------------------------------
// Add Flight
//--------------------------------------------------

document.getElementById("addBtn").addEventListener("click",function(){

    const random=Math.floor(Math.random()*900)+100;

    const newFlight={

        time:"12:"+Math.floor(Math.random()*60).toString().padStart(2,"0"),

        flight:"AI"+random,

        dest:"Hyderabad",

        gate:"E"+Math.floor(Math.random()*5+1),

        status:"ON TIME"

    };

    flights.push(newFlight);

    renderBoard();

});

//--------------------------------------------------
// Reset Board
//--------------------------------------------------

document.getElementById("resetBtn").addEventListener("click",function(){

    flights=JSON.parse(JSON.stringify(originalFlights));

    renderBoard();

});

//--------------------------------------------------
// Live Clock
//--------------------------------------------------

function updateClock(){

    const now=new Date();

    document.getElementById("clock").textContent=
    now.toLocaleTimeString();

}

updateClock();

setInterval(updateClock,1000);

//--------------------------------------------------
// Live Status Update
//--------------------------------------------------

const order=[

"ON TIME",
"BOARDING",
"GATE CLOSED",
"DEPARTED"

];

function updateRandomStatus(){

    const index=Math.floor(Math.random()*flights.length);

    const current=flights[index].status;

    let next=current;

    if(current==="DELAYED"){

        next="BOARDING";

    }

    else{

        let pos=order.indexOf(current);

        if(pos<order.length-1){

            next=order[pos+1];

        }

    }

    flights[index].status=next;

    const cell=document.getElementById("status-"+index);

    if(cell){

        cell.textContent=next;

        setStatusColor(cell,next);

    }

    updateSummary();

}

setInterval(updateRandomStatus,4000);

//--------------------------------------------------
// Summary
//--------------------------------------------------

function updateSummary(){

    const total=flights.length;

    let boarding=0;

    let delayed=0;

    flights.forEach(f=>{

        if(f.status==="BOARDING")
            boarding++;

        if(f.status==="DELAYED")
            delayed++;

    });

    summary.textContent=
    `${total} departures • ${boarding} boarding • ${delayed} delayed`;

}

//--------------------------------------------------

renderBoard();