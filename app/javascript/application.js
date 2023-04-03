//= require jquery
//= require jquery_ujs
//= require jquery.remotipart

$(".search").keyup(function (e) {
  if (e.keyCode == 13) {
    console.log(e.target.value);
  }
});

$(".show_sign").click(function () {
  document.getElementById("sign").classList.toggle("show");
});
$(".show_response_relation").click(function () {
  document.getElementById("response_relation").classList.toggle("show");
});
$(".show_remove_relation").click(function () {
  document.getElementById("remove_relation").classList.toggle("show");
});
$(".show_pending_post_tool").click(function () {
  document.getElementById("pending_post_tool").classList.toggle("show");
});

// Close the dropdown if the user clicks outside of it
window.onclick = function (event) {
  if (!event.target.matches(".sign")) {
    var dropdowns = document.getElementsByClassName("signDropdown");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains("show")) {
        openDropdown.classList.remove("show");
      }
    }
  }
};

$("#open_post_modal").click(function () {
  $("#post_modal").css("display", "block");
});
$("#close_post_modal").click(function () {
  $("#post_modal").css("display", "none");
});
$("#open_group_modal").click(function () {
  $("#group_modal").css("display", "block");
  $(".angle").css("display", "none");
});
$("#close_group_modal").click(function () {
  $("#group_modal").css("display", "none");
  $(".angle").css("display", "block");
});
$("#open_profile_modal").click(function () {
  $("#profile_modal").css("display", "block");
  $(".angle").css("display", "none");
});
$("#close_profile_modal").click(function () {
  $("#profile_modal").css("display", "none");
  $(".angle").css("display", "block");
});

$("#cancel").click(function () {
  $("#set_mode_post_modal").css("display", "none");
});
$("#mode_seleted").click(function () {
  $("#set_mode_post_modal").css("display", "none");
});

// When the user clicks anywhere outside of the modal, close it
window.onclick = function (event) {
  if (event.target == $("#post_modal")[0]) {
    $("#post_modal").css("display", "none");
  }
  if (event.target == $(".drop_down")[0]) {
    $("#post_modal").css("display", "none");
  }
};

$(".friend_url").click(function () {
  window.location.href = "/groups/";
});

$(".member_requested_url").click(function () {
  window.location.href += "/members";
});

$("#show_tool_post").click(function () {
  $("#tool_post").css("display", "block");
  $("#tool_info").css("display", "none");
  $("#tool_member").css("display", "none");
});
$("#show_tool_info").click(function () {
  $("#tool_post").css("display", "none");
  $("#tool_info").css("display", "block");
  $("#tool_member").css("display", "none");
});
$("#show_tool_member").click(function () {
  $("#tool_post").css("display", "none");
  $("#tool_info").css("display", "none");
  $("#tool_member").css("display", "block");
});

$(".submit_form").keypress(function (e) {
  if (e.which == 13) {
    $(this).closest("form").submit();
    $(this).val("");
    e.preventDefault();
  }
});

$(".edit_comment_form")
  .find("form")
  .submit(function (e) {
    $(this).css("display", "none");
    $(this).parent().parent().find(".text").css("display", "flex");
  });

$(".write_comment").click(function () {
  $(this).parent().parent().children("form").css("display", "block");
});

$(".menu_comment").click(function () {
  $(this).parent().children(".drop_down")[0].classList.toggle("show");
});

$(".menu_post").click(function () {
  $(this).parent().children(".drop_down")[0].classList.toggle("show");
});

$(".edit_comment").click(function () {
  $(this)
    .parent()
    .parent()
    .children(".edit_comment_form")
    .find("form")
    .css("display", "block");
  $(this).parent().parent().children(".text").css("display", "none");
});

$(".drop_down")
  .find("button")
  .click(function () {
    $(this).parent().parent().find(".drop_down")[0]?.classList.toggle("show");
  });

$(".drop_down")
  .find("form")
  .click(function () {
    $(this)
      .parent()
      .parent()
      .parent()
      .find(".drop_down")[0]
      .classList.toggle("show");
  });
if ($(".pagination_post").length && $("#posts").length) {
  $(window).on("scroll", function () {
    var more_posts_url = $(".pagination_post .next_page a").attr("href");
    if (more_posts_url) {
      more_posts_url = more_posts_url;
    } else {
      more_posts_url = $(".pagination_post .next a").attr("href");
    }
    if (
      more_posts_url &&
      $(window).scrollTop() > $(document).height() - $(window).height() - 60
    ) {
      $(".pagination_post")
        .find(".pagination")
        .html(
          '<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />'
        );
      $.getScript(more_posts_url);
    }
  });
}

$(".load_comment").click(function () {
  var more_comments_url = $(this)
    .parent()
    .children(".pagination")
    .find(".next_page a")
    .attr("href");
  if (more_comments_url) {
    more_comments_url = more_comments_url;
  } else {
    more_comments_url = $(this)
      .parent()
      .children()
      .children(".pagination")
      .find(".next a")
      .attr("href");
  }
  if (more_comments_url) {
    $(this)
      .parent()
      .children()
      .children(".pagination")
      .html(
        '<img src="/assets/ajax-loader.gif" alt="Loading..." title="Loading..." />'
      );
    $.getScript(more_comments_url);
  }
});

$(".open_rep").click(function () {
  $(this).parent().children(".replies").css("display", "block");
  $(this).remove();
});

$(".open_comment").click(function () {
  $(this)
    .parent()
    .parent()
    .parent()
    .parent()
    .find(".comments")
    .css("display", "block");
});

// slide
let slideIndex = 1;
showSlides(slideIndex);

// Next/previous controls
function plusSlides(n) {
  showSlides((slideIndex += n));
}

// Thumbnail image controls
function currentSlide(n) {
  showSlides((slideIndex = n));
}

function showSlides(n) {
  let i;
  let slides = document.getElementsByClassName("mySlides");
  let dots = document.getElementsByClassName("dot");
  if (n > slides.length) {
    slideIndex = 1;
  }
  if (n < 1) {
    slideIndex = slides.length;
  }
  for (i = 0; i < slides.length; i++) {
    slides[i].style.display = "none";
  }
  for (i = 0; i < dots.length; i++) {
    dots[i].className = dots[i].className.replace(" active", "");
  }
  slides[slideIndex - 1].style.display = "block";
  dots[slideIndex - 1].className += " active";
}

$(".next").click(function () {
  plusSlides(1);
});

$(".prev").click(function () {
  plusSlides(-1);
});
