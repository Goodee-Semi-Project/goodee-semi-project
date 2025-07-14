package com.goodee.semi.service;

import java.io.File;
import java.io.InputStream;
import java.io.OutputStream;
import java.nio.file.Files;
import java.util.UUID;

import org.apache.commons.io.FilenameUtils;

import com.goodee.semi.dao.AttachDao;
import com.goodee.semi.dto.Attach;

import jakarta.servlet.http.Part;

public class AttachService {
	private AttachDao attachDao = new AttachDao();
	
	public static File getUploadDirectory(int type) {
		String dirPath = "C://goodee/upload" + switch (type) {
			case Attach.ACCOUNT -> "/account";
			case Attach.PET -> "/pet";
			case Attach.COURSE -> "/course";
			case Attach.PRE_COURSE -> "/preCourse";
			case Attach.ASSIGN -> "/assign";
			case Attach.SUBMIT -> "/submit";
			case Attach.REVIEW -> "/review";
			case Attach.NOTICE -> "/notice";
			default -> "";
		};
		
		File uploadDir = new File(dirPath);
		if (!uploadDir.exists()) uploadDir.mkdirs();
		
		return uploadDir;
	}
	
	public static Attach handleUploadFile(Part part, File uploadDir) {
		Attach result = null;
		if (part.getSize() > 0) result = getFileMeta(part, uploadDir);
		
		return result;
	}
	
	public static Attach getFileMeta(Part part, File uploadDir) {
		String originName = part.getSubmittedFileName();
		String ext = FilenameUtils.getExtension(originName);
		String name = originName.substring(0, originName.indexOf("."));
		
		String savedName = UUID.randomUUID().toString().replaceAll("-", "");
		File file = new File(uploadDir, savedName + "." + ext);
		
		try (
			InputStream inputStream = part.getInputStream();
			OutputStream outputStream = Files.newOutputStream(file.toPath())
		) {
			inputStream.transferTo(outputStream);
		} catch (Exception e) { e.printStackTrace(); }
		
		Attach attach = new Attach();
		attach.setOriginName(originName);
		attach.setSavedName(savedName + "." + ext);
		
		return attach;
	}
	
	public Attach selectAttachNo(int attachNo) {
		return attachDao.selectAttachNo(attachNo);
	}
}
