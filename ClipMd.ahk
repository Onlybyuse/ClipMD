#Include Gdip_All.ahk
hexoPath := "E:\Hexo\"
PicPath := hexoPath . "themes\landscape\source\img\" 
imageFormat := "png"
filenameFormat := "yyyyMMdd_HHmmss"
httpPath := "http://Onlybyuse.github.io/images/"
isPushWhenSave := false




^F1::
    ; ����ͼƬ��λ�ú͸�ʽ
    FormatTime, currentFilenameFormat, A_Now, %filenameFormat%
    savePath := PicPath . currentFilenameFormat . "." . imageFormat
    saveHttpPath := httpPath . currentFilenameFormat . "." . imageFormat
   createPic(savePath)
   clipboard := "![image](" . saveHttpPath . ")" 
   send, ^v
   if  isPushWhenSave
       send, ^{F2}
return

^F2::
  run,cmd /c cd /D %hexoPath% & hexo g & hexo d 
return


F8::
 ExitApp
return

createPic(PicPath)
{
	pToken := Gdip_Startup() ; Start gdi+
        ; pBitmapAlpha := Gdip_CreateBitmapFromFile(PicPath)
        ;pBitmapAlpha := Gdip_BitmapFromScreen(0, "")

	;pBitmapAlpha := Gdip_BitmapFromScreen(x "|" y "|" width "|" height)
        pBitmapAlpha := Gdip_CreateBitmapFromClipboard()
        ImgWidth := Gdip_GetImageWidth(pBitmapAlpha)  ; ��ȡ��ȣ��߶ȣ���ʡ��
        ImgHeight := Gdip_GetImageHeight(pBitmapAlpha)
 
        Gdip_SaveBitmapToFile(pBitmapAlpha, PicPath,"255") ;��������������ͼƬ����
        Gdip_DisposeImage(pBitmapAlpha)
        
	Gdip_Shutdown(pToken) ; close gdi+
	Traytip, ��ͼ���:, ��: %ImgWidth% ��: %ImgHeight%`n����Ϊ: %PicPath%
}



