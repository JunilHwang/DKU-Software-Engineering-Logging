import java.util.*;

// Sorting Class
public class Sorting {

	// 클래스 내에 사용되는 변수 선언
	private int num, arr[];

	// 생성후 멤버 변수 기본 설정 
	public Sorting(){
		init();
	}

	// 사용자가 입력한 변수를 받아오기.
	public Sorting init(){
		// 스캐너 생성
		Scanner sc = new Scanner(System.in);

		// max number 받아온 후 동적 생성
		System.out.println("Input Number : ");
		num = sc.nextInt();
		arr = new int[num];

		// max nubmer 만큼 정수 입력 받기
		System.out.println(String.format("Input %d integers : ",num));
		for(int i=0; i<num; i++)
			arr[i] = sc.nextInt();

		return this;
	}


	// sorting 실행
	public void exec(){
		// 교환을 위한 변수
		int temp;

		// sorting 실행
		for(int i=0; i<num; i++){
			for(int j=i; j<num; j++)
				if(arr[i] > arr[j]){
					temp = arr[j];
					arr[j] = arr[i];
					arr[i] = temp;
				}

			// 출력
			System.out.print(arr[i]+" ");
		}
	}

	public static void main(String[] org){
		//실행
		new Sorting().exec();
	}


}