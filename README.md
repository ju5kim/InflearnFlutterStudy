# flutter_study_feat_infrun

# 기본 프로젝트 구조
    - URL기준으로 폴더를 나눈다. 서버의 api path 기준으로 작업(swagger나 호출) 
        - 현재 common,restaurant,user,product
            - 하위 폴더 commponent에는 하위위젯을 위주로 셋업한다..
            - 하위 폴더의 model은 DO(DataObject)를 셋업한다.
            - view 단은 전체 화면에 대한 구성을 셋업한다. 
<br/>

## 토큰과 세션과 쿠키
### Token
일반적으로 JWT(json web toekn)을 토큰이라고 한다.
기본적으로 BASE64인코딩을 사용한다.
Header,Payload,Signature의 결합으로 이루어져있다. Signature = 알고리즘 (Header + Payload) 으로 구성되어 있다.
http의 Header에 Authorization 항목에 값을 넣어 주고 받는다.
RefreshToken 과 AccessToken으로 구성되어 있다. RefreshToken이 유효기간이 길다.
Token = 클라이언트에서 쿠기로 저장하지않고 토큰으로 저장한다. 새로운 기술들은 쿠키 형태로 토큰을 저장해서 들고 있을 수 있다.
1. 클라이언트가 "userid:pw" 값을 base64로 인코딩 후 http의 header에 *"Authorization":"Basic $인코딩된 값"*으로 서버에 전송한다.
2. 서버에서 해당 값을 확인 후 / AccessToken과 RefreshToken을 생성해서 / 전송한다. 클라이언트사이드에서 해당 값을 저장해야한다(유저컴퓨터메모리).
3. 유저에서 서버에 요청시  http 해더에 *"Authorization":"Bearer $AccessToken"*과 함께 요청
4. 서버는 해당 Token을 검증하고 정상이면 필요한 로직처리 후 유저에게 전송 // 유효기간이 만료라면 유저에게 401에러 전송
5. 유저는 다시 AccessToken을 받기위해 *"Authorization":"Bearer $RefreshToken"*을 전송
6. 서버는 확인 후 정상이면 유저에게 AccessToken 재발금, 정상이 아니라면  유저 로그아웃 -> (RefreshToken을 보통은 다시 발급하지 않는다.)
7. 유저는 발급 받은 AccessToken 으로 다시 3번 작업(서버에게 api요청)  


### Session
유저의 정보를 서버에서 세션을 생성해서 DB나 서버에 저장하고 유저에게 쿠키로 보내고 유저가 쿠키에 세션정보를 담아서 보내는 것 
1. Session은 서버에서 생성되어 DB에 저장하고 Client 에게 Session을 전송한다.  
2. Client 에서는 쿠키를 통해 저장한다.
3. Client 에서 서버로 요청을 보낼 때 Session Id를 쿠키를 통해서 전송하고 
4. 서버에서 검증을 하고 필요에 따라 로직을 실행한다.
단점은 DB를 스케일링(확장)할 때 horizantal 확장시 어려움이 발생한다.  







## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
