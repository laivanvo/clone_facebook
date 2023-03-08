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
$('.res_fr_drop').click(function () {
  document.getElementById("resFriendDropdown").classList.toggle("show");
});
$('.friend_drop').click(function () {
  document.getElementById("friendDropdown").classList.toggle("show");
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

$('#open_create_post_modal').click(function () {
  $('#create_post_modal').css("display", "block");
})
$('#open_set_mode_post_modal').click(function () {
  $('#set_mode_post_modal').css("display", "block");
})
$('#open_create_group_modal').click(function () {
  $('#create_group_modal').css("display", "block");
})
$('#close_create_post_modal').click(function() {
  $('#create_post_modal').css("display", "none");
})
$('#close_set_mode_modal').click(function() {
  $('#set_mode_post_modal').css("display", "none");
})
$('#close_create_group_modal').click(function() {
  $('#create_group_modal').css("display", "none");
})


$('#cancel').click(function() {
  $('#set_mode_post_modal').css("display", "none");
})
$('#mode_seleted').click(function() {
  $('#set_mode_post_modal').css("display", "none");
})

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == $('#create_post_modal')[0]) {
    $('#create_post_modal').css("display", "none");
  }
  if (event.target == $('#set_mode_post_modal')[0]) {
    $('#set_mode_post_modal').css("display", "none");
  }
}

$("[name='post[mode]']").click(function (e) {
  $('#_mode').html([
    { id: "global", name: "Công khai" },
    { id: "only_friend", name: "Bạn bè" },
    { id: "only_me", name: "Chỉ mình tôi" },
  ].find((mode) => mode.id === e.target.value).name)
})

$('#friend_url').click(function() {
  window.location.href = "/friends"
})

// $('#friend_url').click(function(accept) {
//   $('#friend_url').html = "friends"
// })
