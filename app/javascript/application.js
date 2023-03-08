import "jquery"

$('.search').keyup(function(e){
  if(e.keyCode == 13)
  {
      console.log(e.target.value)
  }
});

$('.show_sign').click(function () {
  document.getElementById("sign").classList.toggle("show");
});
$('.show_response_relation').click(function () {
  document.getElementById("response_relation").classList.toggle("show");
});
$('.show_remove_relation').click(function () {
  document.getElementById("remove_relation").classList.toggle("show");
});
$('.show_pending_post_tool').click(function () {
  document.getElementById("pending_post_tool").classList.toggle("show");
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

$('#open_post_modal').click(function () {
  $('#post_modal').css("display", "block");
})
$('#close_post_modal').click(function() {
  $('#post_modal').css("display", "none");
})
$('#open_group_modal').click(function () {
  $('#group_modal').css("display", "block");
  $('.angle').css("display", "none")
})
$('#close_group_modal').click(function() {
  $('#group_modal').css("display", "none");
  $('.angle').css("display", "block")
})
$('#open_profile_modal').click(function () {
  $('#profile_modal').css("display", "block");
  $('.angle').css("display", "none")
})
$('#close_profile_modal').click(function() {
  $('#profile_modal').css("display", "none");
  $('.angle').css("display", "block")
})


$('#cancel').click(function() {
  $('#set_mode_post_modal').css("display", "none");
})
$('#mode_seleted').click(function() {
  $('#set_mode_post_modal').css("display", "none");
})

// When the user clicks anywhere outside of the modal, close it
window.onclick = function(event) {
  if (event.target == $('#post_modal')[0]) {
    $('#post_modal').css("display", "none");
  }
  if (event.target == $('#post_modal')[0]) {
    $('#post_modal').css("display", "none");
  }
}

$('.friend_url').click(function() {
  window.location.href = "/groups/"
})

$('.member_requested_url').click(function() {
  window.location.href += "/members"
})

$('#show_tool_post').click(function() {
  $('#tool_post').css("display", "block")
  $('#tool_info').css("display", "none")
  $('#tool_member').css("display", "none")
})
$('#show_tool_info').click(function() {
  $('#tool_post').css("display", "none")
  $('#tool_info').css("display", "block")
  $('#tool_member').css("display", "none")
})
$('#show_tool_member').click(function() {
  $('#tool_post').css("display", "none")
  $('#tool_info').css("display", "none")
  $('#tool_member').css("display", "block")
})

// slide

let slideIndex = 1;
showSlides(slideIndex);

// Next/previous controls
function plusSlides(n) {
  showSlides(slideIndex += n);
}

// Thumbnail image controls
function currentSlide(n) {
  showSlides(slideIndex = n);
}

function showSlides(n) {
  let i;
  let slides = document.getElementsByClassName("mySlides");
  let dots = document.getElementsByClassName("dot");
  if (n > slides.length) {slideIndex = 1}
  if (n < 1) {slideIndex = slides.length}
  for (i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";
  }
  for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex-1].style.display = "block";
  dots[slideIndex-1].className += " active";
}

$('.next').click(function () {
  plusSlides(1)
})

$('.prev').click(function () {
  plusSlides(-1)
})
