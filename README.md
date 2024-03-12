# Eclipse Timer - 휴식 시간 타이머

![iphone 6 5](https://github.com/CHOIJUNHYUK01/gym_timer/assets/114978803/5079077e-e65b-43b7-85ab-980cc438f9eb)

<br /><br />

## 개발 배경
운동을 하면서 세트와 세트 사이 휴식 시간을 재기 위해 다양한 방법을 써봤습니다.
1. 핸드폰 내장 타이머로 계산
2. 헬스 앱으로 끝날 때마다 직접 화면 터치
   
결국 핸드폰을 세트가 끝나면 봐야 하거나, 화면을 터치해야 한다는 점에서 불편했습니다.

그래서 이어폰으로 어떻게 탐지할 수 있는 컨트롤이 있지 않을까? 하는 마음에 만들었습니다.

<br /><br />

## 프로젝트 기간

2024.03.04 ~ 2024.03.10 (7일)

<br /><br />

## 개발 환경

### UI
- Code Base UI (UIKit)

### 디자인 패턴
- MVC 패턴

### 사용 기술 및 오픈소스 라이브러리
- [AudioSession](https://developer.apple.com/audio/)
- [airbnb/lottie-ios](https://github.com/airbnb/lottie-ios)

<br /><br />

## 문제 및 해결 과정

### 1. 타이머와 알림 소리가 밀리는 현상 발생 - 내 앱이 오디오 사용을 하기 위한 함수를 부르면 생기는 문제

- 문제 상황

- 문제 파악 과정

쉬는 시간이 끝나기 3초 전부터 알림이 울립니다.
이때 소리가 겹치지 않게 하기 위해 [setActive(_:options:)](https://developer.apple.com/documentation/avfaudio/avaudiosession/1616627-setactive)를 활용합니다.
위 함수는 짧게 끝나긴 하지만, 그래도 길면 수 초가 걸릴 수도 있는 작업입니다.
이때문에 타이머가 잠시 밀리는 현상이 생겼습니다.
저 함수 부분을 비동기로 넘겼습니다.
그렇게 해서 타이머는 고쳐졌지만, 3초 알림 소리가 밀리는 건 여전했습니다.
차라리 타이머를 더 잘 듣게 하기 위해, 저 함수 자체를 1초 전에 실행하도록 바꿨습니다.




