document.addEventListener('turbolinks:load', () => {
  let toggle = document.getElementById("user_menu");
  let dropmenu = document.getElementById("login_dropmenu");

  toggle?.addEventListener('click',function(){
    dropmenu.classList.toggle("active");
  });
});

document.addEventListener('turbolinks:load', () => {
  const dotbuttons = document.querySelectorAll('.dotsicon_text');

  dotbuttons.forEach(button => {
    const menu = button.nextElementSibling;

    if (menu && menu.classList.contains('dotsicon_dropmenu')) {
      button.addEventListener('click', () => {
        menu.classList.toggle('active');
      });
    }
  });
});

document.addEventListener("turbolinks:load", function () {

  const roomElements = document.querySelectorAll('.room');

  roomElements.forEach(room => {

    const roomRate = parseFloat(room.dataset.roomRate);

    const formattedRoomRate = new Intl.NumberFormat('ja-JP', {
      style: 'currency',
      currency: 'JPY',
      minimumFractionDigits: 0,
    }).format(roomRate);

    const convertRateElement = room.nextElementSibling; 
    if (convertRateElement && convertRateElement.classList.contains('convert_rate')) {
      convertRateElement.textContent = formattedRoomRate;
    }
  });
});

