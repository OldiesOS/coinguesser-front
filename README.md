# coinguesser-front

### 브랜치 관리
- `main` : 항상 배포 가능한 상태를 유지
- `develop` : 기능을 테스트하고 안정화 하는 브랜치
- `feature/*` : 개발자가 새로운 기능을 개발하는 브랜치
    - ex : `feature/data-api`, `feature/login`
    - 알아서 이름 지어서 만든 다음에 거기서 작업이용

### Git Action 관련
- 새로운 기능을 추가할 때 test/ 디렉토리에 자신이 개발한 기능에 대한 `feature*.test.js` 파일도 작성해야함
- git action으로 `feature` 브랜치에서 `main` 브랜치로 PR시 자동으로 테스트



---
# API 명세서 
-  이거 바탕으로 웹 구현하시면 돼요
  
## Node.js
### **1. 엔드포인트: 초기 데이터 요청**
- **URL**: `/API/Data/stream/{coin_name}`
- **메서드**: `GET`
- **설명**:  
    - 요청 시간 기준 1시간
    - data 개수 13개 마지막 predicted_value 값은 null값으로 날라가도록 구조 변경했습니다다

#### **요청**
| 이름          | 위치       | 타입     | 필수 여부 | 설명             |
| ----------- | -------- | ------ | ----- | -------------- |
| `coin_name` | 경로(Path) | String | 필수    | 코인 이름 (예: BTC) |

#### **응답 데이터 (초기 요청)**
| 필드명                      | 타입     | 설명                   |
| ------------------------ | ------ | -------------------- |
| `coin`                   | String | 코인 이름                |
| `data`                   | Array  | 초기 그래프 데이터 배열        |
| `data[n].time`           | String | 데이터 시간 (예: HH:mm:ss) |
| `data[n].predicted_value` | Float  | 예측된 값                |
| `data[n].real_value`     | Float  | 실제 값                 |

##### **응답 예시 (JSON)**
```json
{
    "coin": "BTC",
    "data": [
        {
            "time": "10:05:00",
            "predicted_value": 124.22,
            "real_value": 126.32
        },
        {
            "time": "10:10:00",
            "predicted_value": 124.88,
            "real_value": 127.05
        },
        ...
        {
            "time": "10:10:00",
            "predicted_value": 124.88,
            "real_value": null
        }
    ]
}
```
---
### **2. 엔드포인트: SSE 스트림 요청**
- **URL**: `/API/Data/stream/{coin_name}`
- **메서드**: `GET`
- **설명**:  
  - 초기 데이터 요청 후, 동일한 엔드포인트에서 SSE 스트림 연결을 시도
  - 연결이 성공하면 서버가 5분마다 새로운 데이터를 `data:` 형식으로 전송

#### **요청**
| 이름          | 위치       | 타입   | 필수 여부 | 설명                  |
|---------------|------------|--------|-----------|-----------------------|
| `coin_name`   | 경로(Path) | String | 필수      | 코인 이름 (예: BTC)   |

#### **응답 데이터 (SSE 스트림)**
| 필드명                   | 타입     | 설명                   |
| --------------------- | ------ | -------------------- |
| `coin`                | String | 코인 이름                |
| `time`                | String | 데이터 시간 (예: HH:mm:ss) |
| `predicted_val` | Float  | 5분 뒤 예측 값            |
| `real_value`          | Float  | 현재 실제값               |

##### **응답 데이터 형식**
- 데이터 스트림(SSE 형식):
```plaintext
data: {"coin":"BTC","time":"10:05:00","predicted_value":124.88, "real_value":126.32}

data: {"coin":"BTC","time":"10:10:00","predicted_value":124.88,"real_value":127.05}
```
---

### **3.엔드포인트: 중단 요청**
- **URL**: `/API/Data/stream/stop`
- **메서드**: `POST`
- **설명**:
    - 현재 클라이언트의 SSE 연결을 종료
    - 추가적인 본문(body) 데이터 없이 요청만으로 처리
      
#### **요청**
`POST /API/Data/stream/stop HTTP/1.1`

#### **응답 데이터**
|필드명|타입|설명|
|---|---|---|
|`status`|String|중단 처리 결과 메시지.|

##### **응답 예시**
`{   "status": "Connection successfully stopped." }`

