import "jquery"

$('.search').keyup(function(e){
  if(e.keyCode == 13)
  {
      console.log(e.target.value)
  }
});

$('.sign').click(function () {
  document.getElementById("signDropdown").classList.toggle("show");
});

// Close the dropdown if the user clicks outside of it
window.onclick = function(event) {
  if (!event.target.matches('.sign')) {
    var dropdowns = document.getElementsByClassName("signDropdown");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}

$('#myBtn').click(function () {
  $('#myModal').css("display", "block");
})
$('#myBtn1').click(function () {
  $('#myModal1').css("display", "block");
})
$('#close').click(function() {
  $('#myModal').css("display", "none");
})
$('#close1').click(function() {
  $('#myModal1').css("display", "none");
})
$('#cancel').click(function() {
  $('#myModal1').css("display", "none");
})
$('#mode_seleted').click(function() {
  $('#myModal1').css("display", "none");
})

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == $('#myModal')[0]) {
    $('#myModal').css("display", "none");
  }
  if (event.target == $('#myModal1')[0]) {
    $('#myModal1').css("display", "none");
  }
}

$("[name='post[mode]']").click(function (e) {
  $('#_mode').html([
    { id: "global", name: "Công khai" },
    { id: "only_friend", name: "Bạn bè" },
    { id: "only_me", name: "Chỉ mình tôi" },
  ].find((mode) => mode.id === e.target.value).name)
})
