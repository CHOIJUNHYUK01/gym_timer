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

### 문제 상황

<img src="https://github.com/CHOIJUNHYUK01/gym_timer/assets/114978803/a77e2f6e-caf6-41fd-aa11-1dfd20405cd1.gif" width="150" />

### 문제 파악 과정

쉬는 시간이 끝나기 3초 전부터 알림이 울립니다.

이때 소리가 겹치지 않게 하기 위해 [setActive(_:options:)](https://developer.apple.com/documentation/avfaudio/avaudiosession/1616627-setactive)를 활용합니다.

위 함수는 짧게 끝나긴 하지만, 그래도 길면 수 초가 걸릴 수도 있는 작업입니다. 이 때문에 타이머가 잠시 밀리는 현상이 생겼습니다.

### 해결

저 함수 부분을 비동기로 넘겼습니다.

그렇게 해서 타이머는 고쳐졌지만, 3초 알림 소리가 밀리는 건 여전했습니다.

차라리 타이머를 더 잘 듣게 하기 위해, 저 함수 자체를 1초 전에 실행하도록 바꿨습니다.

```swift
private let queue = DispatchQueue(label: "backgroundAudio", qos: .userInitiated, target: nil)
// ... 중략
if elaspedTime == t - 4 { focusAudioOurApp() }
        
if elaspedTime >= t - 3 {
      AudioServicesPlaySystemSound(SystemSoundID(1302))
}
// ... 중략
func focusAudioOurApp() {
         // ... 중략
        queue.async {
            try? self.audioSession.setActive(true, options: .notifyOthersOnDeactivation)
            try? self.audioSession.setCategory(.playback, mode: .default, options: [.duckOthers])
        }
}
```
---

### 2. 볼륨 변경을 실시간으로 하면 다른 앱 음악이 꺼지는 문제 - 볼륨 변경을 실시간으로 알기 위해 setActive()함수를 무조건 불러야 하는 상황

### 문제 상황

이 기능을 넣기 전까지 4초 전과 타이머가 다 됐을 때, `setActive(true)`와 `setActive(false)`를 줘서 오디오 사용을 설정 및 해제를 해줬습니다.

하지만, 볼륨 변경을 알기 위해선 오디오가 항상 내 앱이 중심이 되어야 합니다.

[setCategory(_:mode:options:)](https://developer.apple.com/documentation/avfaudio/avaudiosession/1771734-setcategory)와 같이 선언하지 않으면 타앱 음악이 중지되는 현상이 발생했습니다.

### 문제 파악 과정

`setCategory(_:mode:policy:options:)`함수를 읽어보니, 오디오 세션 카테고리와 모드, 옵션을 정할 수 있게 해주는 함수라는 것을 알게 됐습니다.

그래서 [AVAudioSession.CategoryOptions](https://developer.apple.com/documentation/avfaudio/avaudiosession/categoryoptions)을 보면서 타앱 음악 소리는 유지할 수 있는 옵션을 찾아봤습니다.

### 해결

[mixWithOthers](https://developer.apple.com/documentation/avfaudio/avaudiosession/categoryoptions/1616611-mixwithothers)라는 옵션이 있었습니다.

해당 옵션은 타앱이 오디오를 사용하고 있다면, 그 앱 오디오와 함께 섞어서 사용하겠다는 옵션입니다. 딱 제가 찾던 옵션이었습니다.

이후에는 타이머 3초 알림과 완료 알림이 울릴 때, 옵션만 바꿔주는 식으로 해결했습니다.

```swift
func focusAudioOurApp() {
        // ... 중략
        queue.async {
            try? self.audioSession.setCategory(.playback, mode: .default, options: [.duckOthers])
        }
}
    
func focusOtherAppAudio() {
        // ... 중략
        queue.async {
            try? self.audioSession.setCategory(.playback, mode: .default, options: [.mixWithOthers])
        }
}
```

---

## 구현 기능

- 시간 설정 및 타이머 기능
- 휴식 방법 설정
- 휴식 방법에 따른 기능 구현 (화면 터치, 음량 조절, 음악 일시정지)

## 시연 영상



https://github.com/CHOIJUNHYUK01/gym_timer/assets/114978803/bf3687f6-f356-470c-b289-d10eb724f119



