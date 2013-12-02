(function (window, document, undefined) {
  var external_links_open_in_new_window = function () {
    var elements = all_external_links();
    add_target_blank_to_links(elements);
  };

  var all_external_links = function () {
    return document.querySelectorAll("a[href^=http]");
  };

  var add_target_blank_to_links = function (link_elements) {
    for (var i = link_elements.length - 1; i >= 0; i--) {
      add_target_blank_to_link(link_elements[i]);
    };
  };

  var add_target_blank_to_link = function (element) {
    element.setAttribute("target", "_blank");
  };

  external_links_open_in_new_window();
})(this, this.document);
