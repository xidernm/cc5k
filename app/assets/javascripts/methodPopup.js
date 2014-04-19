methodPopup = function() {
   $.guider({
    title: "How does G.E.R.A Generate these numbers?",
    description: "Agent, G.E.R.A has advanced methods for calculating your carbon emissions. The EIA provides a database including some useful statistics about electric and gas emissions based on location. G.E.R.A uses this database, your information, and your location to compute a good guess about your actual carbon impact. This calculation would take into account, for example, that your electric footprint is small if you live in mostly hydroelectricly powered area.",
    overlay: "dark",
    draggable: true,
    buttons: {
    Close: true
    }
    }).show()

}