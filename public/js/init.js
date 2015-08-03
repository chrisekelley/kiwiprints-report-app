$(document).ready(function() {
  var table = $('#summary').DataTable( {
    //"scrollY":        "400px",
    //"scrollCollapse": true,
    "paging":         false,
    //"lengthMenu": [[10, 25, 50, -1], [10, 25, 50, "All"]]
    //"searching": false,
    //"ordering": false
  } );
  new $.fn.dataTable.FixedHeader( table );
} );
