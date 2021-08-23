package main

import (
	"fmt"
	"io/ioutil"
	"os"
	"strings"
)

type ReplaceMent struct {
	oldTxt string
	newTxt string
}

func main() {
	var (
		rms []ReplaceMent
	)

	rms = append(rms, ReplaceMent{oldTxt: `github.com/ethereum/go-ethereum`,   newTxt: `github.com/spoonerAhua/my-eth`    })

	// replace turingchain
	doReplace("E:\\_git-source\\github.com\\spoonerAhua\\my-eth",      rms )
}

func main_turingchain() {
	var (
		rms []ReplaceMent
	)

	rms = append(rms, ReplaceMent{oldTxt: `CHAIN33`,   newTxt: `TURINGCHAIN`    })
	rms = append(rms, ReplaceMent{oldTxt: `chain33`,   newTxt: `turingchain`    })
	rms = append(rms, ReplaceMent{oldTxt: `Chain33`,   newTxt: `Turingchain`    })
	rms = append(rms, ReplaceMent{oldTxt: `33cn`,      newTxt: `turingchain2020`})
	rms = append(rms, ReplaceMent{oldTxt: `bty`,       newTxt: `trc`            })
	rms = append(rms, ReplaceMent{oldTxt: `Bty`,       newTxt: `Trc`            })
	rms = append(rms, ReplaceMent{oldTxt: `BTY`,       newTxt: `TRC`            })
	rms = append(rms, ReplaceMent{oldTxt: `bityuan`,   newTxt: `turingchaincoin`})
	rms = append(rms, ReplaceMent{oldTxt: `Bityuan`,   newTxt: `Turingchaincoin`})
	rms = append(rms, ReplaceMent{oldTxt: `8801`,      newTxt: `9671`           })
	rms = append(rms, ReplaceMent{oldTxt: `8802`,      newTxt: `9672`           })
	rms = append(rms, ReplaceMent{oldTxt: `8805`,      newTxt: `9675`           })
	//rms = append(rms, ReplaceMent{oldTxt: `13802`,     newTxt: `9675`           }) //*注意恢复* github.com\turingchain2020\turingchain\system\crypto\ed25519\ed25519\edwards25519\const.go
	rms = append(rms, ReplaceMent{oldTxt: `Fuzamei`,   newTxt: `Turing`         })
	rms = append(rms, ReplaceMent{oldTxt: `33.cn`,     newTxt: `__officeSite__` })
	rms = append(rms, ReplaceMent{oldTxt: `复杂美`,     newTxt: `图灵`})

	// replace turingchain
	doReplace("E:/TuringChain2020/TuringChain2020_source/github.com/turingchain2020/plugin",      rms )
	doReplace("E:/TuringChain2020/TuringChain2020_source/github.com/turingchain2020/turingchain", rms )

	// replace turingchain-sdk-java
	//doReplace("E:\\TuringChain2020\\_source\\github.com\\turingchain2020\\turingchain-sdk-java", rms )

}

func doReplace(basePath string,rms []ReplaceMent){
	var (
		err error
		fileInfos []os.FileInfo
	)

	if fileInfos, err = ioutil.ReadDir(basePath); err != nil {
		panic(err)
	}

	for _, x := range fileInfos {
		if x.Name() == ".git" || x.Name() == ".github" {
			continue
		}

		var _name = replaceFileName(basePath, x.Name(), rms)

		if x.IsDir() {
			renameFileName(basePath+"/"+_name, rms)
		} else {
			replaceContent(basePath+"/"+_name, rms)
		}
	}
}

func renameFileName(path string,rms []ReplaceMent) {
	var (
		err error
		fileInfos []os.FileInfo
	)

	if fileInfos, err = ioutil.ReadDir(path);err != nil{
		panic(err)
	}

	for _, x := range fileInfos {
		var _name = replaceFileName(path ,x.Name(), rms)

		if x.IsDir() {
			renameFileName(path + "/" + _name, rms)
		}else{
			replaceContent(path + "/" + _name,rms )
		}
	}
}

func replaceFileName(path string,fileName string, rms []ReplaceMent) string  {
	var newFileName = fileName
	for _, r := range rms {
		var index = strings.Index(fileName, r.oldTxt)
		if index >= 0 {
			newFileName = strings.ReplaceAll(fileName, r.oldTxt, r.newTxt)
			if err := os.Rename(path + "/" + fileName, path + "/" + newFileName); err !=nil{
				panic(err)
			}
			fmt.Println("Renamed File:", path + "/" + fileName, path + "/" + newFileName)
			break
		}
	}
	return newFileName
}

func replaceContent(absoluteFilePath string,rms []ReplaceMent)  {
	var (
		err error
	)

	var contentByte []byte

	if contentByte, err = ioutil.ReadFile(absoluteFilePath); nil != err {
		panic(err)
	}

	var contentStr = string(contentByte)
	var contentChange = false
	for _, r := range rms {
		var index = strings.Index(contentStr, r.oldTxt)
		if index >= 0 {
			contentStr = strings.ReplaceAll(contentStr, r.oldTxt, r.newTxt)
			contentChange = true
		}
	}
	if contentChange {
		if err = ioutil.WriteFile(absoluteFilePath, []byte(contentStr), os.FileMode(0)); err != nil {
			panic(err)
		}
		fmt.Println("Changed File:", absoluteFilePath)
	}
}
