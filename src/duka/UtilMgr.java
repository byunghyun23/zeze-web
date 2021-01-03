package duka;

import java.io.File;
import java.util.StringTokenizer;
import java.util.Map;
import java.util.HashMap;

public class UtilMgr {
	private Map<String, Integer> jobMap =  new HashMap<String, Integer>();
	private Map<Integer, String> jobMap2 =  new HashMap<Integer, String>();


	public int getJobId(String name) {
		return jobMap.get(name);
	}

	public String getJobName(int id) {
		return jobMap2.get(id);
	}

	public UtilMgr() {
		jobMap.put("초보자", 0); 

		jobMap.put("전사", 100); 
		jobMap.put("파이터", 110); jobMap.put("크루세이더", 111); jobMap.put("히어로", 112); 
		jobMap.put("페이지", 120);jobMap.put("나이트", 121); jobMap.put("팔라딘", 122);
		jobMap.put("스피어맨", 130); jobMap.put("용기사", 131);jobMap.put("다크나이트", 132); 

		jobMap.put("마법사", 200); 
		jobMap.put("위자드(불,독)", 210);jobMap.put("메이지(불,독)", 211); jobMap.put("아크메이지(불,독)", 212); 
		jobMap.put("위자드(썬,콜)", 220);jobMap.put("메이지(썬,콜)", 221); jobMap.put("아크메이지(썬,콜)", 222); 
		jobMap.put("클레릭", 230); jobMap.put("프리스트", 231); jobMap.put("비숍", 232);

		jobMap.put("궁수", 300); 
		jobMap.put("헌터", 310);jobMap.put("레인져", 311); jobMap.put("보우마스터", 312); 
		jobMap.put("사수", 320);jobMap.put("저격수", 321); jobMap.put("신궁", 322); 

		jobMap.put("도적", 400); 
		jobMap.put("어쌔신", 410);jobMap.put("허밋", 411); jobMap.put("나이트로드", 412); 
		jobMap.put("시프", 420);jobMap.put("시프마스터", 421); jobMap.put("섀도어", 422); 

		jobMap.put("해적", 500); 
		jobMap.put("인파이터", 510);jobMap.put("버커니어", 511); jobMap.put("바이퍼", 512); 
		jobMap.put("건슬링거", 520);jobMap.put("발키리", 521); jobMap.put("캡틴", 522); 

		jobMap.put("소울마스터 1차", 1100);jobMap.put("소울마스터 2차", 1110); jobMap.put("소울마스터 3차", 1111);
		jobMap.put("플레임위자드 1차", 1200);jobMap.put("플레임위자드 2차", 1210); jobMap.put("플레임위자드 3차", 1211);
		jobMap.put("윈드브레이커 1차", 1300);jobMap.put("윈드브레이커 2차", 1310); jobMap.put("윈드브레이커 3차", 1311);
		jobMap.put("나이트워커 1차", 1400);jobMap.put("나이트워커 2차", 1410); jobMap.put("나이트워커터 3차", 1411);
		jobMap.put("스트라이커 1차", 1500);jobMap.put("스트라이커 2차", 1510); jobMap.put("스트라이커 3차", 1511);
		//

		jobMap2.put(0, "초보자"); 

		jobMap2.put(100, "전사"); 
		jobMap2.put(110, "파이터"); jobMap2.put(111, "크루세이더"); jobMap2.put(112, "히어로"); 
		jobMap2.put(120, "페이지");jobMap2.put(121, "나이트");  jobMap2.put(122, "팔라딘"); 
		jobMap2.put(130, "스피어맨"); jobMap2.put(131, "용기사");jobMap2.put(132, "다크나이트"); 

		jobMap2.put(200, "마법사"); 
		jobMap2.put(210, "위자드(불,독)"); jobMap2.put(211, "메이지(불,독)"); jobMap2.put(212, "아크메이지(불,독)"); 
		jobMap2.put(220, "위자드(썬,콜)"); jobMap2.put(221, "메이지(썬,콜)"); jobMap2.put(222, "아크메이지(썬,콜)"); 
		jobMap2.put(230, "클레릭"); jobMap2.put(231, "프리스트");jobMap2.put(232, "비숍"); 

		jobMap2.put(300, "궁수"); 
		jobMap2.put(310, "헌터"); jobMap2.put(311, "레인져"); jobMap2.put(312, "보우마스터"); 
		jobMap2.put(320, "사수");jobMap2.put(321, "저격수");  jobMap2.put(322, "신궁"); 

		jobMap2.put(400, "도적"); 
		jobMap2.put(410, "어쌔신"); jobMap2.put(411, "허밋"); jobMap2.put(412, "나이트로드"); 
		jobMap2.put(420, "시프"); jobMap2.put(421, "시프마스터");jobMap2.put(422, "섀도어"); 

		jobMap2.put(500, "해적"); 
		jobMap2.put(510, "인파이터"); jobMap2.put(511, "버커니어"); jobMap2.put(512, "바이퍼"); 
		jobMap2.put(520, "건슬링거"); jobMap2.put(521, "발키리");jobMap2.put(522, "캡틴");
		
		jobMap2.put(1100, "소울마스터"); jobMap2.put(1110, "소울마스터"); jobMap2.put(1111, "소울마스터");
		jobMap2.put(1200, "플레임위자드"); jobMap2.put(1210, "플레임위자드"); jobMap2.put(1211, "플레임위자드"); 
		jobMap2.put(1300, "윈드브레이커"); jobMap2.put(1310, "윈드브레이커"); jobMap2.put(1311, "윈드브레이커"); 
		jobMap2.put(1400, "나이트워커"); jobMap2.put(1410, "나이트워커"); jobMap2.put(1411, "나이트워커"); 
		jobMap2.put(1500, "스트라이커"); jobMap2.put(1510, "스트라이커"); jobMap2.put(1511, "스트라이커"); 

	}

	public static String replace(String str, String pattern, String replace) {
		int s = 0, e = 0;
		StringBuffer result = new StringBuffer();

		while ((e = str.indexOf(pattern, s)) >= 0) {
			result.append(str.substring(s, e));
			result.append(replace);
			s = e + pattern.length();
		}
		result.append(str.substring(s));
		return result.toString();
	}

	public static void delete(String s) {
		File file = new File(s);
		if (file.isFile()) {
			file.delete();
		}
	}

	public static String con(String s) {
		String str = null;
		try {
			str = new String(s.getBytes("8859_1"), "ksc5601");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return str;
	}
}