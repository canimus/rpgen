function get_person() {
  d3.json("/people", function(err, person) {
    // Name
    d3.select("#pname").text(person.name);

    // Filling personal details
    d3.select("#sofinummer").attr("value",person.sofinummer);
    d3.select("#initials").attr("value",person.initials);
    d3.select("#sex").attr("value",person.sex);
    d3.select("#phone").attr("value",person.phone);
    d3.select("#email").attr("value",person.email);



    // Filling address information
    d3.select("#street").attr("value",person.street);
    d3.select("#house").attr("value",person.house);
    d3.select("#city").attr("value",person.city);
    d3.select("#regio").attr("value",person.regio);
    d3.select("#postcode").attr("value",person.postcode);

    if (person.counter-1 >= 0) {
      d3.select("#counter").text("Available items: " + (person.counter-1));
    }

  });
}
