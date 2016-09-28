package com.solar.tech.utils;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.FileUploadException;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;

public class UploadHelper {  
    private String tmpPath;  
    private String savePath;  
      
    /** 
     * @return the tmpPath 
     */  
    public String getTmpPath() {  
        return tmpPath;  
    }  
  
    /** 
     * @param tmpPath the tmpPath to set 
     */  
    public void setTmpPath(String tmpPath) {  
        this.tmpPath = tmpPath;  
    }  
  
    /** 
     * @return the savePath 
     */  
    public String getSavePath() {  
        return savePath;  
    }  
  
    /** 
     * @param savePath the savePath to set 
     */  
    public void setSavePath(String savePath) {  
        this.savePath = savePath;  
    }  
  
    public List<String> handleUplodFile(HttpServletRequest request) throws FileUploadException, IOException{  
        File tmpDir = new File(getTmpPath());  
        File saveDir = new File(getSavePath());  
          
        List<String> result = new ArrayList<String>();  
        if (!ServletFileUpload.isMultipartContent(request)) {  
            return result;  
        }  
          
        DiskFileItemFactory dff = new DiskFileItemFactory();  
        dff.setRepository(tmpDir);// 指定上传文件的临时目录  
        dff.setSizeThreshold(1024000);// 指定在内存中缓存数据大小,单位为byte  
        ServletFileUpload sfu = new ServletFileUpload(dff);// 创建该对象  
        FileItemIterator fii;                 
        fii = sfu.getItemIterator(request);  
        while (fii.hasNext()) {           
            FileItemStream fis = fii.next();  
            if (fis.isFormField() || fis.getName().length() == 0)  
                continue;  

            String fileName = formatFileName(fis.getName());  
            System.out.println("新文件名："+fileName);
            BufferedInputStream in = new BufferedInputStream(fis.openStream());// 获得文件输入流  
            File file = new File(saveDir, fileName);  
            System.out.println("====》》》："+in);
            BufferedOutputStream out = new BufferedOutputStream(new FileOutputStream(file));// 获得文件输出流  
            Streams.copy(in, out, true);// 开始把文件写到你指定的上传文件夹  
              
            result.add(fileName);  
        }  
        return result;  
    }  
      
    private String formatFileName(String fileName){  
        return new SimpleDateFormat("yyyyMMddHHmmssSSS").format(new Date()) + fileName.substring(fileName.lastIndexOf("."));  
        //return fileName;  
    }  
}