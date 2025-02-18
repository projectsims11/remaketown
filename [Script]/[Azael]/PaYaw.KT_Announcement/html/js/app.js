let queue = [];
let maxQueue = 0;
let isSetup = false;

const onReceive = (text, duration, picture, color) => {
  const queueId = queue.length + 1;

  queue = [...queue, { id: queueId, picture, text }];
  $('.container').append(`
    <div class="card" qid="${queueId}">
      <div class="decor" style="background: ${color};">
        <div class="logo">
          <img src="./images/${picture}" alt="${picture}">
        </div>
      </div>
      <div class="text">
        ${text}
      </div>
    </div>
  `);

  setTimeout(() => {
    const $card = $(`.card[qid=${queueId}]`);

    // $card.find('.text').fadeOut()
    $card.find('.text').html("")
    $card.find('.text').addClass('end');
    $card.addClass('end');
    $card.find('.decor').fadeOut();

    setTimeout(() => {
      removeArrayFromId(queueId);
      $card.remove();
    }, 1500);
  }, duration);
};

const removeArrayFromId = (id) => {
  if (queue.length <= 0) return;
  queue = queue.filter((value) => value.id != id);
};

window.addEventListener('message', (event) => {
  const item = event.data;

  switch (item.action) {
    case 'onSetupConfig':
      maxQueue = item.maximum;
      isSetup = true;
      break;
    case 'onReceive':
      if (queue.length >= maxQueue || !isSetup) return;
      onReceive(item.text, item.duration, item.pic, item.color);
      break;
  }
});
