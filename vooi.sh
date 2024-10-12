#!/bin/bash

# 색상 정의
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # 색상 초기화

echo -e "${GREEN}VOOI 봇을 설치합니다.${NC}"
echo -e "${GREEN}스크립트작성자: https://t.me/kjkresearch${NC}"
echo -e "${GREEN}출처: https://github.com/codenewinsight/VOOI-Telegram-Bot-backed-by-Binance${NC}"
echo -e "${GREEN}게임설치: https://t.me/VooiAppBot/vooi?startapp=frenIDl8j7lPJ${NC}"

echo -e "${CYAN}이 봇은 다음과 같은 기능을 갖고 있습니다.{NC}"
echo -e "${CYAN}오토트레이드 / 오토탭/ 오토태스크{NC}"

echo -e "${GREEN}설치 옵션을 선택하세요:${NC}"
echo -e "${YELLOW}1. VOOI 봇 새로 설치${NC}"
echo -e "${YELLOW}2. 기존정보 그대로 이용하기(재실행)${NC}"
echo -e "${YELLOW}3. VOOI 봇 업데이트${NC}"
read -p "선택: " choice

case $choice in
  1)
    echo -e "${GREEN}VOOI 봇을 새로 설치합니다.${NC}"

    #필요한 패키지 설치
    echo -e "${YELLOW}시스템 업데이트 및 필수 패키지 설치 중...${NC}"
    rm -rf /root/VOOI-Telegram-Bot-backed-by-Binance
    sudo apt update
    sudo apt install -y git

    # GitHub에서 코드 복사
    echo -e "${YELLOW}GitHub에서 코드 복사 중...${NC}"
    git clone https://github.com/codenewinsight/VOOI-Telegram-Bot-backed-by-Binance.git

    # 환경변수 설정
    WORK="/root/VOOI-Telegram-Bot-backed-by-Binance"


    # 작업 공간 생성 및 이동
    echo -e "${YELLOW}작업 공간 이동 중...${NC}"
    cd "$WORK"

    echo -e "${YELLOW}파이썬 설치 중...${NC}"
    sudo apt update
    sudo apt install python3
    sudo apt install python3-pip
    pip install -r requirements.txt

    echo -e "${GREEN}다계정을 구동하기 위해선 각 query_id마다 같은 개수의 프록시가 필요합니다.${NC}"
    echo -e "${GREEN}query_id를 얻는 방법은 텔레그램 그룹방을 참고하세요.하나의 텔레그렘 계정에서 쿼리ID는 동일합니다.${NC}"
    echo -e "${GREEN}여러 개의 query_id를 입력할 경우 줄바꿈으로 구분하세요.${NC}"
    echo -e "${GREEN}입력을 마치려면 엔터를 두 번 누르세요.${NC}"
    echo -e "${YELLOW}query_id를 입력하세요:${NC}"

    # data.txt 파일 생성 및 초기화
    {
        while IFS= read -r line; do
            [[ -z "$line" ]] && break
            echo "$line"
        done
    } > "$WORK"/data.txt

    # 사용자에게 프록시 사용 여부를 물어봅니다.
    read -p "프록시를 사용하시겠습니까? (y/n): " use_proxy
    
    if [[ "$use_proxy" == "y" || "$use_proxy" == "Y" ]]; then
       
        cd "$WORK"
        # 프록시 정보 입력 안내
        echo -e "${YELLOW}프록시 정보를 입력하세요. 입력형식: http://user:pass@ip:port${NC}"
        echo -e "${YELLOW}여러 개의 프록시는 줄바꿈으로 구분하세요.${NC}"
        echo -e "${YELLOW}입력을 마치려면 엔터를 두 번 누르세요.${NC}"

        # proxy.txt 파일 생성 및 초기화
        {
            while IFS= read -r line; do
                [[ -z "$line" ]] && break
                echo "$line"
            done
        } > "$WORK"/proxy.txt
        
        # 봇 구동
        python3 vooi-proxy.py
    else
        cd "$WORK"
        python3 vooi.py
    fi
    ;;

  2)
    echo -e "${GREEN}Vooi 봇을 재실행합니다.${NC}"
    
    # 사용자에게 프록시 사용 여부를 물어봅니다.
    read -p "프록시를 사용하시겠습니까? (y/n): " use_proxy
    
    if [[ "$use_proxy" == "y" || "$use_proxy" == "Y" ]]; then
        cd "$WORK"
        python3 vooi-proxy.py
    else
        cd "$WORK"
        python3 vooi.py
    fi
    ;;

  *)
    echo -e "${RED}잘못된 선택입니다. 다시 시도하세요.${NC}"
    ;;
esac
