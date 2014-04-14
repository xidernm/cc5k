showGuiders = function() {
   console.log("Called");
   $.guider({
    next: "hq",
    title: "Welcome To G.E.R.A Headquarters",
    description: "Hello friend, and welcome to the Global Emissions Reduction Alliance. The fact that you have taken the time to receive y    our security clearance tells us you are valuable new asset dedicated to our cause. Do you want me to show you around the application,     or would you like to explore on your own?",
    overlay: "dark",
    draggable: true,
    buttons: {
    Close: true,
    Next: {
    click: true,
    className: "primary",
    focus: true
    }
    }
    }).show()
    $('#hq').guider({
    name: "hq",
    next: "misobj",
    title: "Headquarters",
    description: "This is the landing page for our application. It will contain any notifications that are relevant to you, as well as an     action items and new awards.",
    overlay: "dark",
    draggable: true,
    buttons: {
    Close: true,
    Next: {
    click: true,
    className: "primary",
    focus: true
    }
    }
    })

    $('#misobj').guider({
    name: "misobj",
    next: "prof",
    title: "Mission Objective",
    description: "This area contains information about G.E.R.A's goals and the status quo between us and Big Petroleum",
    overlay: "dark",
    draggable: true,
    buttons: {
    Close: true,
    Next: {
    click: true,
    className: "primary",
    focus: true
    }
    }
    })
    $('#prof').guider({
    name: "prof",
    next: "contrib",
    title: "Personnel File",
    description: "G.E.R.A members may view their records and awards, and update their contact information directly in their personnel file.",
    overlay: "dark",
    draggable: true,
    buttons: {
    Close: true,
    Next: {
    click: true,
    className: "primary",
    focus: true
    }
    }
    })
    $('#contrib').guider({
    name: "contrib",
    next: "mission",
    title: "Intelligence",
    description: "Here you can view charts and statistics about your progress in the fight against carbon emissions and Big Petroleum.",
    overlay: "dark",
    draggable: true,
    buttons: {
    Close: true,
    Next: {
    click: true,
    className: "primary",
    focus: true
    }
    }
    })
    $('#missions').guider({
    name: "mission",
    next: "final",
    title: "Missions",
    description: "Here you will find a listing of your current assignments and objective in the fight against Big Petroleum.",
    overlay: "dark",
    draggable: true,
    buttons: {
    Close: true,
    Next: {
    click: true,
    className: "primary",
    focus: true
    }
    }
    })
    $.guider({
    name: "final",
    title: "Welcome",
    description: "Now that you have a better understanding of the application it's time to get started fighting Big Petroleum. Click on 'missions' to see your objectives. You can access this tool again by clicking 'Show me how to use this application' near the bottom of the page",
    overlay: "dark",
    draggable: true,
    buttons: {
    Close: true   
    }
    })
}
