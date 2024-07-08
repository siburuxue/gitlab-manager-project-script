package main

import (
	"flag"
	"fmt"
	"os"
	"strings"

	"gopkg.in/gomail.v2"
)

func main() {
	subject := ""
	body := ""
	to := ""
	c := ""
	flag.StringVar(&subject, "s", "", "")
	flag.StringVar(&body, "b", "", "")
	flag.StringVar(&to, "t", "", "")
	flag.StringVar(&c, "c", "", "")
	flag.Parse()
	fmt.Println(subject)
	fmt.Println(body)
	username := "usename1"
	password := "password1"
	host := "smtp.exmail.qq.com"
	port := 465
	if to == "" {
		to = "xxxx@mail.com"
	}
	var cc []string
	if c == "" {
		cc = append(cc, "xxxx1@mail.com")
		cc = append(cc, "xxxx2@mail.com")
		cc = append(cc, "xxxx3@mail.com")
		cc = append(cc, "xxxx4@mail.com")
		cc = append(cc, "xxxx5@mail.com")
		cc = append(cc, "xxxx6@mail.com")
		cc = append(cc, "xxxx7@mail.com")
		cc = append(cc, "xxxx8@mail.com")
		cc = append(cc, "xxxx9@mail.com")
		cc = append(cc, "xxxx10@mail.com")
		cc = append(cc, "xxxx11@mail.com")
		cc = append(cc, "xxxx12@mail.com")
		cc = append(cc, "xxxx13@mail.com")
		cc = append(cc, "xxxx14@mail.com")
		cc = append(cc, "xxxx15@mail.com")
		cc = append(cc, "xxxx16@mail.com")
	} else {
		cc = strings.Split(c, ",")
	}
	m := gomail.NewMessage()
	m.SetHeader("From", username)
	m.SetHeader("To", to)
	m.SetHeader("Cc", cc...)
	m.SetHeader("Subject", subject)
	m.SetBody("text/html", body)
	d := gomail.NewDialer(host, port, username, password)
	if err := d.DialAndSend(m); err != nil {
		fmt.Println(err.Error())
		os.Exit(1)
	}
	os.Exit(0)
}
