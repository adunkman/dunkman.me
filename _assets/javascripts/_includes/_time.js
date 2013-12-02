(function (window, document, undefined) {
  var locale_options = {
    weekday: undefined, year: "numeric", month: "long", day: "numeric"
  };

  var localize_time_on_page = function () {
    var elements = all_time_elements_on_page();
    localize_time_elements(elements);
  };

  var all_time_elements_on_page = function () {
    return document.querySelectorAll("time");
  };

  var localize_time_elements = function (time_elements) {
    for (var i = time_elements.length - 1; i >= 0; i--) {
      localize_time_element(time_elements[i]);
    }
  };

  var localize_time_element = function (element) {
    var datetime = element.getAttribute("datetime");
    var date = new Date(datetime);
    var localized_string = date.toLocaleDateString(undefined, locale_options);

    element.innerHTML = localized_string;
  };

  localize_time_on_page();
})(this, this.document);
