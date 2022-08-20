const STATE_INIT = 3000;
const STATE_READY = 3001;
const STATE_PLAYING = 3002;
const STATE_JUDGE = 3004;
const STATE_END = 3005;

const TIME = 5;
const SCORE = 5;
const QUESTION = [
  {
    type: true,
    content: "달팽이도 이빨이 있는가?",
    answer: "true",
  },
  {
    type: true,
    content: "딸기는 장미과에 속하는가??",
    answer: "true",
  },
  {
    type: true,
    content: "하마는 말의 일종인가?",
    answer: "true",
  },
  {
    type: false,
    content:
      "18세기 중엽 영국에서 시작된 기술혁신과 이에 수반하여 일어난 사회 · 경제 구조의 변혁을 무엇이라 할까요??",
    answer: "산업혁명",
  },
  {
    type: true,
    content:
      "미국 캘리포니아주 남서부 애너하임에 위치해 있는 세계적인 유원지이자, 대규모의 오락시설인 이곳은 어디일까요?",
    answer: "true",
  },
];

let _isGameOpened = false;
let _state = STATE_INIT;
let _start = false;
let _stateTimer = 0;
let _timer = 20;
let _isKeyPressed = false;
let _currentSpeaker = null;
let _currentQuestion = null;
let _currentAnswer = null;
let _result = null;
let _players = [];
let _currentQuestionNumber = 0;

// 플레이어가 입장할 때 동작하는 함수
App.onJoinPlayer.Add(function (player) {
  player.tag = {
    widget: null,
    score: 0,
  };
  player.sendUpdated();
  player.tag.widget = player.showWidget("widget.html", "top", 600, 500);
  // 게임 시작 위젯에서 메시지 보낸 경우
  player.tag.widget.onMessage.Add(function (player, msg) {
    // 위젯에서 App으로 'type: close'라는 메시지를 보내면 위젯을 파괴함
    if (msg.type == "close") {
      player.showCenterLabel("위젯이 닫혔습니다.");
      player.tag.widget.destroy();
      player.tag.widget = null;
      _isGameOpened = false;
    } else if (msg.type == "start") {
      startGame(STATE_INIT);
      //   for (var p in _players) {
      //     if (p.tag.widget != null) {
      //       p.tag.widget.destroy();
      //       p.tag.widget = null;
      //       // ßp.sendUpdated();
      //     }
      //   }
    }
    player.sendUpdated();
  });
  _players.push(player);
});

// // 한 명의 유저만 사이드앱을 열 수 있게 함
// App.onSidebarTouched.Add(function (player) {
//   if (_isGameOpened == true) {
//     player.tag.widget.destroy();
//   }
// });

function startGame(state) {
  App.sayToAll(_players);
  if (state != STATE_INIT) {
    return;
  }
  App.showCenterLabel("게임이 곧 시작됩니다.");
  App.runLater(function () {
    App.showCenterLabel("퀴즈 게임 시작! 답을 외치려면 q키를 입력하세요.");
    _start = true;
    _state = STATE_READY;
  }, 3);
}

App.onUpdate.Add(function (dt) {
  if (_currentQuestionNumber == QUESTION.length) {
    _state = STATE_END;
  } else {
    // const type = QUESTION[_currentQuestionNumber].type;
    _currentQuestion = QUESTION[_currentQuestionNumber].content;
    _currentAnswer = QUESTION[_currentQuestionNumber].answer;
  }
  if (!_start) {
    return;
  }
  _stateTimer += dt;

  switch (_state) {
    case STATE_INIT:
      break;
    case STATE_READY:
      App.runLater(function () {
        App.showCenterLabel(`Q. ${_currentQuestion}`);
        _timer = 20;
        _stateTimer = 0;
        _state = STATE_PLAYING;
      }, 3);
      break;
    case STATE_PLAYING:
      if (_stateTimer >= 1) {
        _stateTimer = 0;
        _timer -= 1;
      }
      if (_timer <= 0) {
        App.showCenterLabel(`정답은 ${_currentAnswer}입니다!`);
        _currentSpeaker = null;
        _state = STATE_JUDGE;
      }
      // 유저가 버저 누르는경우 (z)
      App.addOnKeyDown(90, function (player) {
        if (_isKeyPressed == true) {
          // 되면 누가 먼저 정답 외쳤다고 메시지 띄우기
          return;
        } else {
          _isKeyPressed = true;
          _currentSpeaker = player.id;
        }
        App.showCenterLabel(`${player.name} 님이 답변을 입력합니다.`);
      });

      App.onSay.add(function (player, text) {
        App.sayToAll(text);
        if (_currentSpeaker != player.id) {
          return;
        }
        if (_currentAnswer == text) {
          _currentSpeaker = player.name;
          player.tag.score += SCORE;
          player.sendUpdated();
          _state = STATE_JUDGE;
          return;
        } else {
          App.showCenterLabel("정답이 아닙니다!!");
          _isKeyPressed = false;
          _currentSpeaker = null;
        }
      });
      break;
    case STATE_JUDGE:
      if (_currentSpeaker != null) {
        App.showCenterLabel(`${_currentSpeaker} 님이 정답을 맞히셨습니다!`);
      } else {
        App.showCenterLabel(`아무도 정답을 맞히지 못했습니다. 이런!`);
      }
      _isKeyPressed = false;
      _currentSpeaker = null;
      _currentQuestionNumber += 1;
      _state = STATE_READY;
      break;
    case STATE_END:
      App.sayToAll(_players);
      for (var player in _players) {
        App.sayToAll(player.tag.score);
      }
      return;
      winner = findFinalWinner();
      App.showCenterLabel(`🎉최종 우승자는 ${winner.join(" ")} 님입니다!🎉`);
      initGame();
      break;
  }
});

function findFinalWinner() {
  var maxScore = 0;
  var winner = [];
  for (var player in _players) {
    App.sayToAll(player.tag.score);
    if (player.tag.score > maxScore) {
      winner = [player.name];
    } else if (player.tag.score == maxScore) {
      winner.push(player.name);
    }
  }
  return winner;
}

function initGame() {
  _start = false;
  _isGameOpened = false;
  _state = STATE_INIT;
  _timer = 20;
  _isKeyPressed = false;
  _currentSpeaker = null;
  _currentQuestion = null;
  _currentAnswer = null;
  _currentQuestionNumber = 0;
}
