package board;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;
import com.oreilly.servlet.multipart.FileRenamePolicy;

public class FileUtil {

	private static FileUtil instance = new FileUtil();
	
	public static FileUtil getInstance() {
		return instance;
	}
	
	private FileUtil() {}
	
	private final String saveDirectory = "C:\\upload";
	private final int maxPostSize = 1024 * 1024 * 50;
	private final String encoding = "UTF-8";
	private final FileRenamePolicy policy = new DefaultFileRenamePolicy();
	
	
	public BoardDTO getDTO(HttpServletRequest request) throws IOException {
		BoardDTO dto = new BoardDTO();
		MultipartRequest mpRequest = new MultipartRequest(
				request, saveDirectory, maxPostSize, encoding, policy);
		
				File uploadFile = mpRequest.getFile("uploadFile");
				
				if (uploadFile != null) {
					dto.setImage(uploadFile.getName());
				}
				dto.setIdx(Integer.parseInt(mpRequest.getParameter("idx")));
				dto.setTitle(mpRequest.getParameter("title"));
				dto.setWriter(mpRequest.getParameter("writer"));
				dto.setContent(mpRequest.getParameter("content"));
				dto.setCategory(mpRequest.getParameter("category"));
				return dto;
		
		
		
		
		
	}
	
}
