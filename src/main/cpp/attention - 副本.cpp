
#include <algorithm>
#include <iostream>
using namespace std;


//Prefilling timing simulator
// int main2(){
// 	//A transformer / QWen1 layer (prefill)
// 	int dModel = 32;
// 	int numHeads = 2;
// 	int Batch = 1;
// 	int Seq = 2;

// 	dModel = 1024;
// 	numHeads = 16;
// 	Batch = 1;
// 	Seq = 1024;

// 	dModel = 256;
// 	numHeads = 4;
// 	Batch = 1;
// 	Seq = 256;
		
// 	//L1 - 16x8 = 128kb
// 	int Kcache = 16000;
// 	int Vcache = 16000;
// 	int Qcache = 16000;
// 	int PScache = 16000; 
							   
// 	int Xcache = 16000 ;                           
// 	int Wkcache = 16000;                            
// 	int Wvcache = 16000;                           
// 	int Wqcache = 16000;
	
// 	//Memory sparsity related
// 	int Window = 0; //Phi() = (nn > 0)
		
// 	//DRAM
// 	int DRAM_read_cyc = 4;
// 	int SRAM_read_cyc = 2;
// 	int MULT_cyc = 1;
		
// 	int DimB = Batch   ;
// 	int DimN = Seq     ;
// 	int DimH = numHeads    ;
// 	int DimM = Seq     ;
// 	int DimD = dModel  ;
// 	int DimE = dModel  ;
// 	int DimO = dModel  ;

// 	int SH = 2;
// 	int SN = 4;
// 	int SB = 1;
// 	int SM = 4;
// 	int SE = 64;
// 	int SD = 8;

// 	int SNN = 16;
// 	int SMM = 16;
// 	int SDD = 64;
	
	
// 	SH = 1;SN = 1;SB = 1;SM = 1;SE = 128;SD = 128;
// 	SNN = 16; SMM = 16; SDD = 256;
	
// 	//1. 
// 	SH = 1;SN = 1;SB = 1;SM = 1;SE = 64;SD = 64; SO = 64;
// 	SNN = 16; SMM = 16; SDD = 128;
		
// 	// SH = 1;SN = 8;SB = 1;SM = 8;SE = 64;SD = 8;
// 	// SH = 2;SN = 4;SB = 1;SM = 4;SE = 64;SD = 8;
// 	// SH = 2;SN = 4;SB = 1;SM = 4;SE = 8;SD = 64;
// 	// SH = 4;SN = 4;SB = 1;SM = 4;SE = 32;SD = 8;
// 	// SH = 1;SN = 16;SB = 1;SM = 16;SE = 64;SD = 4;
				
	
// 	//simulator
// 	unsigned long long cycles = 0;
// 	unsigned long long actual_cycles = 0;
// 	unsigned long long xreuse = 0;
// 	unsigned long long wkreuse = 0;
// 	unsigned long long wqreuse = 0;
// 	unsigned long long kreuse = 0;
// 	unsigned long long qreuse = 0;
	
// 	double total_en = 0;
// 	unsigned long long K_en = 0;
// 	unsigned long long Q_en = 0;
// 	unsigned long long V_en = 0;
// 	unsigned long long S_en = 0;
// 	unsigned long long SM_en = 0;
// 	unsigned long long O_en = 0;

	
// 	float scale = 1e9/1e12;
	
// 	int TK =SD*SE*SB*SH*SM;   
// 	int TQ =SD*SE*SB*SH*SN;   
// 	int TV =SO*SE*SB*SH*SM;   
// 	int TS =SD*SB*SH*SM*SN;   
// 	int TSM=SB*SH*SM*SN;      
// 	int TO =  SB*SH*SM*SN*SO;
	
// 	int TTotal = TK+TQ+TV+TS+TSM+TO;
	
// 	double RK = ((double) TK )/TTotal;
// 	double RQ = ((double) TQ )/TTotal;
// 	double RV = ((double) TV )/TTotal;
// 	double RS = ((double) TS )/TTotal;
// 	double RSM= ((double) TSM)/TTotal; 
// 	double RO = ((double) TO )/TTotal;
	
	
	
// 	float TFLOP_K  =scale* SD*SE*SB*SH*SM;   
// 	float TFLOP_Q  =scale* SD*SE*SB*SH*SN;   
// 	float TFLOP_V  =scale* SD*SE*SB*SH*SM;   
// 	float TFLOP_S  =scale* SD*SB*SH*SM*SN;   
// 	float TFLOP_SM =scale* SB*SH*SM*SN;      
// 	float TFLOP_O  =scale*   SB*SH*SM*SN*SD;
	
	
	
	
		
// 	for(int nnn = 0; nnn < DimN; nnn += SNN){
// 	for(int mmm = 0; mmm < DimM; mmm += SMM){
// 	for(int ddd = 0; ddd < DimD; ddd += SDD){



// #if(OS)	
// 	//Output stationary
// 	//	   E D  M  N     H      B      DD    NN      MM
// 	//X  = 1 E  E  E   EN/EM   EN/EM  ENB/EM  EN/EM  EN/EM
// 	//     N R  N  N    R       N      R     N        N
// 	//Wq = 1 1 ED ED    ED     EDH           EDH     EDH
// 	//	   N N  R  R    N       R            R        R
// 	//Wk = 1 1 ED ED   ED      EDH           EDH     EDH
// 	//     N N  R  R    N       R            R        R
// 	//KV =   1  1 DM 
// 	//             R                          R         
// 	//Q  =      D                                     
// 	//          R
// 	//S/P= No reuse
// 	//     - -                                           
// 	for(int b = 0; b < DimB; b += SB){
// 	for(int h = 0; h < DimH; h += SH){
// 	for(int n = 0; n+nnn < std::min(DimN,nnn+SNN); n += SN){	
// 	// for(int o = 0; o < DimO; o += SO){
// 	for(int m = 0; m+mmm < std::min(DimM,mmm+SMM); m += SM){
// 	for(int d = 0; d+ddd < std::min(DimD,ddd+SDD); d += SD){
// 	for(int e = 0; e < DimE; e += SE){

// 			int X_reuse = (DimE <= Xcache & d > 0) | 
// 				(std::max(DimE*SNN, DimE*SMM) <= Xcache & h > 0) |
// 				(DimB*DimE*std::max(SNN, SMM) <= Xcache & ddd > 0) |
// 				(DimE*SMM <= Xcache & o > 0)
// 				;
// 			int Wk_reuse = (DimE*SDD <= Wkcache & m > 0) | (DimE*SDD <= Wkcache & n > 0) | 
// 				(DimE*SDD*DimH <= Wkcache & b > 0) |
// 				(DimE*DimD*DimH <= Wkcache & nnn > 0) |
// 				(DimE*DimD*DimH <= Wkcache & mmm > 0) |
// 				(DimE*SDD <= Wkcache & o > 0);
				
// 			int Wq_reuse= (DimE*SDD <= Wqcache & m > 0) | (DimE*SDD <= Wqcache & n > 0) | 
// 				(DimE*SDD*DimH <= Wqcache & b > 0) |
// 				(DimE*DimD*DimH <= Wqcache & nnn > 0) |
// 				(DimE*DimD*DimH <= Wqcache & mmm > 0) |
// 				(DimE*SDD <= Wqcache & o > 0);//(DimE*DimD < Wqcache & m > 0) | (std::max(DimE*SNN, DimE*SMM) < Xcache & h > 0);
			
// 			int K_reuse = (SDD*SMM <= Kcache & n > 0) |
// 				(DimD*DimH*DimB*SMM <= Kcache & nnn > 0) |
// 				(SDD*SMM <= Kcache & o > 0) 
// 				;
			
// 			int V_reuse = (SDD*SMM <= Vcache & n > 0) |
// 				(DimD*DimH*DimB*SMM <= Vcache & nnn > 0) |
// 				(SDD*SMM <= Vcache & o > 0) 
// 				;
				
// 			int PS_reuse = (SMM <=  PScache & o > 0);
			
// 			int Q_reuse = (SDD <= Qcache & m > 0) |
// 				(DimD*DimH*DimB*SMM <= Qcache & mmm > 0) |
// 				(SDD*SMM <= Qcache & o > 0) 
// 				;
			
// #endif

// #if(XS)	
// 	//Input stationary 
// 	//	   D  H  E  M     N      B      DD    NN      MM
// 	//X  = 1  1  1  1     1      1     EMB       
// 	//     R  R  N  N     R      N      R     N        N
// 	//Wq = 1  1  1 EDH    EDH   EDH           EDH     EDH
// 	//	   N  N  N  R     N      R      N     N        R
// 	//Wk = 1 1 ED ED   ED      EDH           EDH     EDH
// 	//     N N  R  R    N       R            R        R
// 	//K  =               DHM
// 	// 						R                R
// 	//Q  =           R                                   R
   
// 	for(int b = 0; b < DimB; b += SB){
// 	for(int n = 0; n+nnn < std::min(DimN,nnn+SNN); n += SN){	
// 	for(int m = 0; m+mmm < std::min(DimM,mmm+SMM); m += SM){
// 	for(int e = 0; e < DimE; e += SE){
// 	for(int h = 0; h < DimH; h += SH){
// 	for(int d = 0; d+ddd < std::min(DimD,ddd+SDD); d += SD){

// 		int X_reuse = (1 <= Xcache & d > 0) | 
// 			(1 <= Xcache & h > 0) | 
// 			(DimB*DimE*std::max(SNN, SMM) <= Xcache & ddd > 0) ;

// 		int Wk_reuse = (DimE*SDD*DimH <= Wkcache & b > 0) |
// 			(DimE*SDD*DimH <= Wkcache & m > 0) |
// 			(DimE*SDD*DimH <= Wkcache & n > 0) |
// 			(DimE*DimD*DimH <= Wkcache & nnn > 0) |
// 			(DimE*DimD*DimH <= Wkcache & mmm > 0) ;

// 		int Wq_reuse= (DimE*SDD*DimH <= Wqcache & b > 0) |
// 			(DimE*SDD*DimH <= Wqcache & n > 0) |
// 			(DimE*SDD*DimH <= Wqcache & m > 0) |
// 			(DimE*DimD*DimH <= Wqcache & nnn > 0) |
// 			(DimE*DimD*DimH <= Wqcache & mmm > 0) ;//(DimE*DimD < Wqcache & m > 0) | (std::max(DimE*SNN, DimE*SMM) < Xcache & h > 0);

// 		int K_reuse = (SDD*DimH*SMM <= Kcache & n > 0) |
// 			(DimD*DimH*DimB*SMM <= Kcache & nnn > 0) ;

// 		int V_reuse = (0);

// 		int Q_reuse = (SDD*DimH <= Qcache & m > 0) |
// 			(DimD*DimH*DimB*DimN <= Qcache & mmm > 0) ;

// #endif			
						
// #if(WS)	
// 	//Weight stationary 
// 	for(int h = 0; h < DimH; h += SH){
// 	for(int d = 0; d+ddd < std::min(DimD,ddd+SDD); d += SD){
// 	for(int e = 0; e < DimE; e += SE){
// 	for(int b = 0; b < DimB; b += SB){
// 	for(int n = 0; n+nnn < std::min(DimN,nnn+SNN); n += SN){	
// 	for(int m = 0; m+mmm < std::min(DimM,mmm+SMM); m += SM){

// 		int X_reuse = (DimB*DimE*std::max(SNN, SMM) <= Xcache & d > 0) | 
// 			(DimB*DimE*std::max(SNN, SMM) <= Xcache & h > 0) | 
// 			(DimB*DimE*std::max(SNN, SMM) <= Xcache & ddd > 0) ;

// 		int Wk_reuse = (1 <= Wkcache & b > 0) |
// 			(1 <= Wkcache & m > 0) |
// 			(1 <= Wkcache & n > 0) |
// 			(DimE*DimD*DimH <= Wkcache & nnn > 0) |
// 			(DimE*DimD*DimH <= Wkcache & mmm > 0) ;

// 		int Wq_reuse= (1 <= Wqcache & b > 0) |
// 			(1 <= Wqcache & n > 0) |
// 			(1 <= Wqcache & m > 0) |
// 			(DimE*DimD*DimH <= Wqcache & nnn > 0) |
// 			(DimE*DimD*DimH <= Wqcache & mmm > 0) ;//(DimE*DimD < Wqcache & m > 0) | (std::max(DimE*SNN, DimE*SMM) < Xcache & h > 0);

// 		int K_reuse = (SMM <= Kcache & n > 0) |
// 			(DimD*DimH*DimB*SMM <= Kcache & nnn > 0) ;

// 		int V_reuse = (0);

// 		int Q_reuse = (1 <= Qcache & m > 0) |
// 			(DimD*DimH*DimB*DimN <= Qcache & mmm > 0) ;

// #endif			
							
			
// #if(KS)	
// 	//Key stationary 
// 	for(int b = 0; b < DimB; b += SB){		
// 	for(int d = 0; d+ddd < std::min(DimD,ddd+SDD); d += SD){
// 	for(int h = 0; h < DimH; h += SH){
// 	for(int m = 0; m+mmm < std::min(DimM,mmm+SMM); m += SM){
// 	for(int n = 0; n+nnn < std::min(DimN,nnn+SNN); n += SN){
// 	for(int e = 0; e < DimE; e += SE){

// 		int X_reuse = (DimB*DimE*std::max(SNN, SMM) <= Xcache & d > 0) | 
// 			(DimB*DimE*std::max(SNN, SMM) <= Xcache & h > 0) | 
// 			(DimB*DimE*std::max(SNN, SMM) <= Xcache & ddd > 0) ;

// 		int Wk_reuse = (1 <= Wkcache & b > 0) |
// 			(1 <= Wkcache & m > 0) |
// 			(1 <= Wkcache & n > 0) |
// 			(DimE*DimD*DimH <= Wkcache & nnn > 0) |
// 			(DimE*DimD*DimH <= Wkcache & mmm > 0) ;

// 		int Wq_reuse= (DimE*SDD*DimH <= Wqcache & b > 0) |
// 			(DimE <= Wqcache & n > 0) |
// 			(DimE <= Wqcache & m > 0) |
// 			(DimE*DimD*DimH <= Wqcache & nnn > 0) |
// 			(DimE*DimD*DimH <= Wqcache & mmm > 0) ;//(DimE*DimD < Wqcache & m > 0) | (std::max(DimE*SNN, DimE*SMM) < Xcache & h > 0);

// 		int K_reuse = (1 <= Kcache & n > 0) |
// 			(DimD*DimH*DimB*SMM <= Kcache & nnn > 0) ;

// 		int V_reuse = (0);

// 		int Q_reuse = (SNN <= Qcache & m > 0) |
// 			(DimD*DimH*DimB*DimN <= Qcache & mmm > 0) ;

// #endif						
			
// #if(QS)	
// 	//Query stationary 
// 	for(int b = 0; b < DimB; b += SB){	
// 	for(int n = 0; n+nnn < std::min(DimN,nnn+SNN); n += SN){
// 	for(int h = 0; h < DimH; h += SH){
// 	for(int d = 0; d+ddd < std::min(DimD,ddd+SDD); d += SD){
// 	for(int m = 0; m+mmm < std::min(DimM,mmm+SMM); m += SM){
// 	for(int e = 0; e < DimE; e += SE){

// 		int X_reuse = (DimE*SMM <= Xcache & d > 0) | 
// 			(DimE*SMM <= Xcache & h > 0) | 
// 			(DimB*DimE*std::max(SNN, SMM) <= Xcache & ddd > 0) ;

// 		int Wk_reuse = (DimE*SDD*DimH <= Wkcache & b > 0) |
// 			(DimE <= Wkcache & m > 0) |
// 			(DimE*SDD*DimH <= Wkcache & n > 0) |
// 			(DimE*DimD*DimH <= Wkcache & nnn > 0) |
// 			(DimE*DimD*DimH <= Wkcache & mmm > 0) ;

// 		int Wq_reuse= (DimE*SDD*DimH <= Wqcache & b > 0) |
// 			(DimE <= Wqcache & n > 0) |
// 			(DimE*SDD*DimH <= Wqcache & m > 0) |
// 			(DimE*DimD*DimH <= Wqcache & nnn > 0) |
// 			(DimE*DimD*DimH <= Wqcache & mmm > 0) ;//(DimE*DimD < Wqcache & m > 0) | (std::max(DimE*SNN, DimE*SMM) < Xcache & h > 0);

// 		int K_reuse = (SDD*SMM*DimH <= Kcache & n > 0) |
// 			(DimD*DimH*DimB*SMM <= Kcache & nnn > 0) ;

// 		int V_reuse = (0);

// 		int Q_reuse = (1 <= Qcache & m > 0) |
// 			(DimD*DimH*DimB*DimN <= Qcache & mmm > 0) ;

// #endif
			
	
			
// 			//1. All cache miss
// 			// std::cout << "(b "<< b<<
// 			// 			 ",n "<< n<<
// 			// 			 ",m "<< m<<
// 			// 			 ",h "<< h<<
// 			// 			 ",d "<< d<<
// 			// 			 ",e "<< e << std::endl;
						 
// 			// std::cout << "Xreuse " << X_reuse << std::endl;
// 			total_en += 1;
// 			cycles += MULT_cyc;
// 			xreuse += X_reuse;
// 			wqreuse += Wq_reuse;
// 			wkreuse += Wk_reuse;
// 			wkreuse += Wk_reuse;
// 			kreuse += K_reuse;
// 			qreuse += Q_reuse;
			
// 			if(e+SE>=DimE){
// 				S_en += 1;
// 			}
// 			if(d+SD>=DimD){
// 				SM_en += 1;
// 				O_en += 1;
// 			}
// 			K_en += 1;
// 			Q_en += 1;
// 			V_en += 1;
			
// 			int cycle_round = 0;
// 			int reuse_round = SRAM_read_cyc;
// 			int round = 0;
// 			//todos
// 			if(K_reuse & Q_reuse){
// 				if(e+SE>=DimE){
// 					round = max(reuse_round, cycle_round);;
// 				}
// 			}else if(K_reuse){
// 				if(xreuse){
// 				}else{
// 					cycle_round +=	DRAM_read_cyc;
// 				}
// 				if(wqreuse){
// 				}else{
// 					cycle_round +=	DRAM_read_cyc;
// 				}
// 				round = max(reuse_round, cycle_round);;
// 			}else if(Q_reuse){
// 				if(xreuse){
// 				}else{
// 					cycle_round +=	DRAM_read_cyc;
// 				}
// 				if(wkreuse){
// 				}else{
// 					cycle_round +=	DRAM_read_cyc;
// 				}			
// 				round = max(reuse_round, cycle_round);;
// 			}else{
// 				if(xreuse){
// 				}else{
// 					cycle_round +=	DRAM_read_cyc;
// 				}
// 				if(wqreuse){
// 				}else{
// 					cycle_round +=	DRAM_read_cyc;
// 				}
// 				if(wkreuse){
// 				}else{
// 					cycle_round +=	DRAM_read_cyc;
// 				}		
// 				round = max(reuse_round, cycle_round);;
// 			}
				

			
			
// 			actual_cycles += round;
			
// 			if(cycles % 10240000 == 0){
// 				std::cout << "(b "<< b<<
// 							 ",n "<< n<<
// 							 ",m "<< m<<
// 							 ",h "<< h<<
// 							 ",d "<< d<<
// 							 ",e "<< e << std::endl;
							 
// 				std::cout << "Xreuse " << xreuse << std::endl;	
							
// 				std::cout << "wqreuse " << wqreuse << std::endl;	
				
// 				std::cout << "wkreuse " << wkreuse << std::endl;	
				
// 				std::cout << "ideal_cycles" << cycles << std::endl;
// 				std::cout << "actual_cycles" << actual_cycles << std::endl;
// 				std::cout << "utilization" << (float) cycles / (float) actual_cycles << std::endl;
				
				
// 				float util = (K_en/total_en)*RK + 
// 							 (V_en/total_en)*RV + 
// 							 (Q_en/total_en)*RQ + 
// 							 (S_en/total_en)*RS + 
// 							 (SM_en/total_en)*RSM + 
// 							 (O_en/total_en)*RO;
// 				// cout << (K_en/total_en)<<endl;
			
// 				// std::cout << "utilization" << "("<< K_en/total_en << "," << S_en/total_en <<")" << std::endl;
// 				std::cout << "util: " << util << endl;
// 			}
			
// 		// for(int bb = b; bb < std::min(bb+SB, DimB); bb++){
// 		// for(int nn = n; nn < std::min(nn+SN, DimN); nn++){
// 		// for(int hh = h; hh < std::min(hh+SH, DimH); hh++){
// 		// for(int mm = m; mm < std::min(mm+SM, DimM); mm++){
// 		// for(int dd = d; dd < std::min(dd+SD, DimD); dd++){
// 		// for(int ee = e; ee < std::min(ee+SE, DimE); ee++){

		
// 		// }}}}}}
		
				
// 	}}}}}}
	
// 	}}}
	
// 	cout << endl;
// 	std::cout << "Simulation Summary" << std::endl;
// 	std::cout << "-----------------------" << std::endl;
// 	std::cout << "cycles " << cycles << std::endl;
// 	std::cout << "runtime " << actual_cycles/1e9 << std::endl;
// 	cout << "xreuse " << xreuse << endl;
// 	cout << "wqreuse " << wqreuse << endl;
// 	cout << "wkreuse "  << wkreuse << endl;
// 	cout << "K_reuse" << kreuse << endl;
// 	cout << "Q_reuse" << qreuse << endl;
	
// 	cout << "TFLOP_K  " << TFLOP_K  << endl;
// 	cout << "TFLOP_Q  " << TFLOP_Q  << endl;
// 	cout << "TFLOP_V  " << TFLOP_V  << endl;
// 	cout << "TFLOP_S  " << TFLOP_S  << endl;
// 	cout << "TFLOP_SM " << TFLOP_SM << endl;
// 	cout << "TFLOP_O  " << TFLOP_O  << endl;
	
// 	cout << "TFLOPS " << (TFLOP_K + TFLOP_Q + TFLOP_V + TFLOP_S + TFLOP_SM + TFLOP_O) <<endl;
// 	return 0;
	
// 	// int SH = 1;
// 	// int SN = 1;
// 	// int SB = 1;
// 	// int SM = 1;
// 	// int SE = 64;
// 	// int SD = 64;
	
// }




int prefill_mha_sparsity(){
	//A transformer / QWen1 layer (prefill)
	int dModel = 32;
	int numHeads = 2;
	int Batch = 1;
	int Seq = 2;

	dModel = 1024;
	numHeads = 16;
	Batch = 8;
	Seq = 1024;
	
	//L1 - 16x8 = 128kb
	int cache = 16000;
	
	// #if(CACHE)
	// 	cache = CACHE;
	// #endif
	
	int Kcache  = cache;
	int Vcache  = cache;
	int Qcache  = cache;
	int PScache = cache; 	   
	int Xcache  = cache ;                           
	int Wkcache = cache;                            
	int Wvcache = cache;                           
	int Wqcache = cache;
		
	//Memory sparsity related
	int Window = 0; //Phi() = (nn > 0)
		
	//DRAM
	int DRAM_read_cyc = 8;
	int SRAM_read_cyc = 2;
	int MULT_cyc = 1;
		
	int DimB = Batch   ;
	int DimN = Seq     ;
	int DimH = numHeads    ;
	int DimM = Seq     ;
	int DimD = dModel  ;
	int DimE = dModel  ;

	int SH = 1;
	int SN = 1;
	int SB = 1;
	int SM = 1;
	int SE = 64;
	int SD = 64;
	
	int SNN = 16;
	int SMM = 16;
	int SDD = 64;
	
	//Compute group sparsity
	int SSH = SH*1;
	int SSN = SN*1;
	int SSB = SB*1;
	int SSM = SM*1;
	int SSE = SE*1;
	int SSD = SD*1;
	
	//Compute Value sparsity
	int H = 2; int HH = H*1; 
	int N = 2; int NN = N*1;
	int B = 2; int BB = B*1;
	int M = 2; int MM = M*1;
	int E = 2; int EE = E*1;
	int D = 2; int DD = D*1;

	

	

	//Focus on embedding
	#if(TILE1)
	
	H = 1 ;	   N =  1;		 B = 1;      M = 1;           E = 64;     D = 64;
	HH=H*1;    NN = N*1; 	 BB = B*1;   MM = M*1;        EE = E*1;   DD = D*1; // Tile Partitioning
	SH = HH*1; SN = NN*1;	 SB = BB*1;  SM = MM*1;       SE = EE*1;  SD = DD*1;// SO = 64;
	
	//Group tiling
	SSH = SH*1; SSN = SN*1;  SSB = SB*1;  SSM = SM*1;     SSE = SE*1;  SDD = SD*1;  
	
	//Secondary tiling
	SNN = 64; SMM = 64; SDD = 128;
	#endif
	
	
	#if(TILE2)
	// //Focus embedding + Softmax
	SH = 1;SN = 64;SB = 1;SM = 32;SE = 64;SD = 1;// SO = 64;
	SNN = 128; SMM = 128; SDD = 128;
	#endif

	#if(TILE3)
	// //Focus on softmax
	SH = 1;SN = 12;SB = 1;SM = 8;SE = 1;SD = 64;// SO = 64;
	SNN = 64; SMM = 64; SDD = 128;
	#endif
	
	#if(TILE4)
	// //Focus on heads
	SH = 4;SN = 12;SB = 1;SM = 8;SE = 1;SD = 16;// SO = 64;
	SNN = 64; SMM = 64; SDD = 128;
	#endif
	
	#if(TILE5)
	// //Focus on balanced
	SH = 1;SN = 16;SB = 4;SM = 16;SE = 4;SD = 4;// SO = 64;
	SNN = 64; SMM = 64; SDD = 128;
	#endif

	#if(TILE6)
	// //Focus on balanced
	SH = 4;SN = 16;SB = 1;SM = 16;SE = 64;SD = 1;// SO = 64;
	SNN = 64; SMM = 64; SDD = 128;
	#endif
	
	
	#if(TILE7)
	// //Focus on balanced
	SH = 1;SN = 16;SB = 1;SM = 16;SE = 16;SD = 8;// SO = 64;
	SNN = 64; SMM = 64; SDD = 128;
	#endif

	// Sparsity set
	int X_zero = 0;
	int W_zero = 0;
	
	float ratio = 0.23;
	float X_sparse  = ratio;
	float Wk_sparse = ratio;
	float Wv_sparse = ratio;
	float Wq_sparse = ratio;
	
	int skip = 1/ratio;
	// float K_sparse = ?
	// float V_sparse = ?
	// float S_sparse = ?
	
	//structured, random
	int sparse_type = 0;
	
	
	
	int Xktest [SB*SM*SE];
	int Wktest [SH*SE*SD];
	int Wqtest [SH*SE*SD];
	int Xqtest [SB*SN*SE];
	
	for(int bb = 0; bb < SB; bb++){
	for(int mm = 0; mm < SM; mm++){
	for(int ee = 0; ee < SE; ee++){	
		Xktest[bb + SB*(mm + SM*ee)] = 1;
	}}}
	
	for(int bb = 0; bb < SB; bb++){
	for(int nn = 0; nn < SN; nn++){
	for(int ee = 0; ee < SE; ee++){	
		Xqtest[bb + SB*(nn + SN*ee)] = 1;
	}}}
	
	for(int hh = 0; hh < SH; hh++){
	for(int dd = 0; dd < SD; dd++){
	for(int ee = 0; ee < SE; ee++){	
		Wqtest[ee + SE*(dd + SD*hh)] = 1;
	}}}
	
	for(int hh = 0; hh < SH; hh++){
	for(int dd = 0; dd < SD; dd++){
	for(int ee = 0; ee < SE; ee++){	
		Wktest[ee + SE*(dd + SD*hh)] = 1;
	}}}
	
	if(sparse_type == 1){
		int idx=0;
		
		for(int bb = 0; bb < SB; bb++){
		for(int mm = 0; mm < SM; mm++){
		for(int ee = 0; ee < SE; ee++){	
			idx ++;
			if(idx % skip == 0){
				Xktest[bb + SB*(mm + SM*ee)] = 0;
			}
		}}}
		idx=0;
		for(int bb = 0; bb < SB; bb++){
		for(int nn = 0; nn < SN; nn++){
		for(int ee = 0; ee < SE; ee++){	
			idx ++;
			if(idx % skip == 0){
				Xqtest[bb + SB*(nn + SN*ee)] = 1;
			}
		}}}
		idx=0;
		for(int hh = 0; hh < SH; hh++){
		for(int dd = 0; dd < SD; dd++){
		for(int ee = 0; ee < SE; ee++){	
			idx ++;
			if(idx % skip == 0){
				Wqtest[ee + SE*(dd + SD*hh)] = 1;
			}
		}}}
		
		idx=0;
		for(int hh = 0; hh < SH; hh++){
		for(int dd = 0; dd < SD; dd++){
		for(int ee = 0; ee < SE; ee++){	
			idx ++;
			if(idx % skip == 0){
				Wktest[ee + SE*(dd + SD*hh)] = 0;
			}
		}}}		
	}
	
	//Estimated sparse skipping
	float K_ratio = 1.0;
	float Q_ratio = 1.0;
	for(int bb = 0; bb < SB; bb++){
	for(int nn = 0; nn < SN; nn++){
	for(int hh = 0; hh < SH; hh++){
	for(int mm = 0; mm < SM; mm++){
	for(int dd = 0; dd < SD; dd++){
	for(int ee = 0; ee < SE; ee++){
		
		// cout << SN / N << endl;
		// cout << SM / M << endl;
		
	}}}}}}
	
									
	// SH = 1;SN = 8;SB = 1;SM = 8;SE = 64;SD = 8;
	// SH = 2;SN = 4;SB = 1;SM = 4;SE = 64;SD = 8;
	// SH = 2;SN = 4;SB = 1;SM = 4;SE = 8;SD = 64;
	// SH = 4;SN = 4;SB = 1;SM = 4;SE = 32;SD = 8;
	// SH = 1;SN = 16;SB = 1;SM = 16;SE = 64;SD = 4;
			
	//simulator
	unsigned long long cycles = 0;
	unsigned long long actual_cycles = 0;
	unsigned long long xreuse = 0;
	unsigned long long wkreuse = 0;
	unsigned long long wqreuse = 0;
	unsigned long long kreuse = 0;
	unsigned long long qreuse = 0;
	
	double total_en = 0;
	unsigned long long K_en  = 0;
	unsigned long long Q_en  = 0;
	unsigned long long V_en  = 0;
	unsigned long long S_en  = 0;
	unsigned long long SM_en  = 0;
	unsigned long long O_en  = 0;

	unsigned long long ideal_K_en  = 0;
	unsigned long long ideal_Q_en  = 0;
	unsigned long long ideal_V_en  = 0;
	unsigned long long ideal_S_en  = 0;
	unsigned long long ideal_SM_en  = 0;
	unsigned long long ideal_O_en  = 0;
	
	float scale = 1e9/1e12;
	
	int TK =SD*SE*SB*SH*SM;   
	int TQ =SD*SE*SB*SH*SN;   
	int TV =SD*SE*SB*SH*SM;   
	int TS =SD*SB*SH*SM*SN;   
	int TSM=SB*SH*SM*SN;      
	int TO =  SB*SH*SM*SN*SD;
	
	int TTotal = TK+TQ+TV+TS+TSM+TO;
	
	double RK = ((double) TK )/TTotal;
	double RQ = ((double) TQ )/TTotal;
	double RV = ((double) TV )/TTotal;
	double RS = ((double) TS )/TTotal;
	double RSM= ((double) TSM)/TTotal; 
	double RO = ((double) TO )/TTotal;
	
	
	
	float TFLOP_K  =scale* DD*EE*BB*HH*MM;   
	float TFLOP_Q  =scale* DD*EE*BB*HH*MM;   
	float TFLOP_V  =scale* DD*EE*BB*HH*MM;   
	float TFLOP_S  =scale* DD*BB*HH*MM*NN;   
	float TFLOP_SM =scale* BB*HH*MM*NN;     
	float TFLOP_O  =scale* BB*HH*MM*NN*DD;
	
	
	//Sparsity conditions
	//Assuming value sparsity = X==0, W==0
	//Assuming group sparsity = Pool(K)Pool(Q)
	
		
	for(int nnn = 0; nnn < DimN; nnn += SNN){
	for(int mmm = 0; mmm < DimM; mmm += SMM){
	for(int ddd = 0; ddd < DimD; ddd += SDD){



#if(OS)	
	//Output stationary
	//	   E D  M  N     H      B      DD    NN      MM
	//X  = 1 E  E  E   EN/EM   EN/EM  ENB/EM  EN/EM  EN/EM
	//     N R  N  N    R       N      R     N        N
	//Wq = 1 1 ED ED    ED     EDH           EDH     EDH
	//	   N N  R  R    N       R            R        R
	//Wk = 1 1 ED ED   ED      EDH           EDH     EDH
	//     N N  R  R    N       R            R        R
	//KV =   1  1 DM 
	//             R                          R         
	//Q  =      D                                     
	//          R
	//S/P= No reuse
	//     - -                                           
	for(int b = 0; b < DimB; b += SB){
	for(int h = 0; h < DimH; h += SH){
	for(int n = 0; n+nnn < std::min(DimN,nnn+SNN); n += SN){	
	for(int m = 0; m+mmm < std::min(DimM,mmm+SMM); m += SM){
	for(int d = 0; d+ddd < std::min(DimD,ddd+SDD); d += SD){
	for(int e = 0; e < DimE; e += SE){

			int X_reuse = (DimE <= Xcache & d > 0) | 
				(std::max(DimE*SNN, DimE*SMM) <= Xcache & h > 0) |
				(DimB*DimE*std::max(SNN, SMM) <= Xcache & ddd > 0) 
				;
			int Wk_reuse = (DimE*SDD <= Wkcache & m > 0) | (DimE*SDD <= Wkcache & n > 0) | 
				(DimE*SDD*DimH <= Wkcache & b > 0) |
				(DimE*DimD*DimH <= Wkcache & nnn > 0) |
				(DimE*DimD*DimH <= Wkcache & mmm > 0) ;
				
			int Wq_reuse= (DimE*SDD <= Wqcache & m > 0) | (DimE*SDD <= Wqcache & n > 0) | 
				(DimE*SDD*DimH <= Wqcache & b > 0) |
				(DimE*DimD*DimH <= Wqcache & nnn > 0) |
				(DimE*DimD*DimH <= Wqcache & mmm > 0) ;//(DimE*DimD < Wqcache & m > 0) | (std::max(DimE*SNN, DimE*SMM) < Xcache & h > 0);
			
			int K_reuse = (SDD*SMM <= Kcache & n > 0) |
				(DimD*DimH*DimB*SMM <= Kcache & nnn > 0) 
				;
			
			int V_reuse = (0);
			
			int Q_reuse = (SDD <= Qcache & m > 0) |
				(DimD*DimH*DimB*SMM <= Qcache & mmm > 0) 
				;
			
#endif

#if(XS)	
	//Input stationary 
	//	   D  H  E  M     N      B      DD    NN      MM
	//X  = 1  1  1  1     1      1     EMB       
	//     R  R  N  N     R      N      R     N        N
	//Wq = 1  1  1 EDH    EDH   EDH           EDH     EDH
	//	   N  N  N  R     N      R      N     N        R
	//Wk = 1 1 ED ED   ED      EDH           EDH     EDH
	//     N N  R  R    N       R            R        R
	//K  =               DHM
	// 						R                R
	//Q  =           R                                   R
   
	for(int b = 0; b < DimB; b += SB){
	for(int n = 0; n+nnn < std::min(DimN,nnn+SNN); n += SN){	
	for(int m = 0; m+mmm < std::min(DimM,mmm+SMM); m += SM){
	for(int e = 0; e < DimE; e += SE){
	for(int h = 0; h < DimH; h += SH){
	for(int d = 0; d+ddd < std::min(DimD,ddd+SDD); d += SD){

		int X_reuse = (1 <= Xcache & d > 0) | 
			(1 <= Xcache & h > 0) | 
			(DimB*DimE*std::max(SNN, SMM) <= Xcache & ddd > 0) ;

		int Wk_reuse = (DimE*SDD*DimH <= Wkcache & b > 0) |
			(DimE*SDD*DimH <= Wkcache & m > 0) |
			(DimE*SDD*DimH <= Wkcache & n > 0) |
			(DimE*DimD*DimH <= Wkcache & nnn > 0) |
			(DimE*DimD*DimH <= Wkcache & mmm > 0) ;

		int Wq_reuse= (DimE*SDD*DimH <= Wqcache & b > 0) |
			(DimE*SDD*DimH <= Wqcache & n > 0) |
			(DimE*SDD*DimH <= Wqcache & m > 0) |
			(DimE*DimD*DimH <= Wqcache & nnn > 0) |
			(DimE*DimD*DimH <= Wqcache & mmm > 0) ;//(DimE*DimD < Wqcache & m > 0) | (std::max(DimE*SNN, DimE*SMM) < Xcache & h > 0);

		int K_reuse = (SDD*DimH*SMM <= Kcache & n > 0) |
			(DimD*DimH*DimB*SMM <= Kcache & nnn > 0) ;

		int V_reuse = (0);

		int Q_reuse = (SDD*DimH <= Qcache & m > 0) |
			(DimD*DimH*DimB*DimN <= Qcache & mmm > 0) ;

#endif			
						
#if(WS)	
	//Weight stationary 
	for(int h = 0; h < DimH; h += SH){
	for(int d = 0; d+ddd < std::min(DimD,ddd+SDD); d += SD){
	for(int e = 0; e < DimE; e += SE){
	for(int b = 0; b < DimB; b += SB){
	for(int n = 0; n+nnn < std::min(DimN,nnn+SNN); n += SN){	
	for(int m = 0; m+mmm < std::min(DimM,mmm+SMM); m += SM){

		int X_reuse = (DimB*DimE*std::max(SNN, SMM) <= Xcache & d > 0) | 
			(DimB*DimE*std::max(SNN, SMM) <= Xcache & h > 0) | 
			(DimB*DimE*std::max(SNN, SMM) <= Xcache & ddd > 0) ;

		int Wk_reuse = (1 <= Wkcache & b > 0) |
			(1 <= Wkcache & m > 0) |
			(1 <= Wkcache & n > 0) |
			(DimE*DimD*DimH <= Wkcache & nnn > 0) |
			(DimE*DimD*DimH <= Wkcache & mmm > 0) ;

		int Wq_reuse= (1 <= Wqcache & b > 0) |
			(1 <= Wqcache & n > 0) |
			(1 <= Wqcache & m > 0) |
			(DimE*DimD*DimH <= Wqcache & nnn > 0) |
			(DimE*DimD*DimH <= Wqcache & mmm > 0) ;//(DimE*DimD < Wqcache & m > 0) | (std::max(DimE*SNN, DimE*SMM) < Xcache & h > 0);

		int K_reuse = (SMM <= Kcache & n > 0) |
			(DimD*DimH*DimB*SMM <= Kcache & nnn > 0) ;

		int V_reuse = (0);

		int Q_reuse = (1 <= Qcache & m > 0) |
			(DimD*DimH*DimB*DimN <= Qcache & mmm > 0) ;

#endif			
							
			
#if(KS)	
	//Key stationary 
	for(int b = 0; b < DimB; b += SB){		
	for(int d = 0; d+ddd < std::min(DimD,ddd+SDD); d += SD){
	for(int h = 0; h < DimH; h += SH){
	for(int m = 0; m+mmm < std::min(DimM,mmm+SMM); m += SM){
	for(int n = 0; n+nnn < std::min(DimN,nnn+SNN); n += SN){
	for(int e = 0; e < DimE; e += SE){

		int X_reuse = (DimB*DimE*std::max(SNN, SMM) <= Xcache & d > 0) | 
			(DimB*DimE*std::max(SNN, SMM) <= Xcache & h > 0) | 
			(DimB*DimE*std::max(SNN, SMM) <= Xcache & ddd > 0) ;

		int Wk_reuse = (1 <= Wkcache & b > 0) |
			(1 <= Wkcache & m > 0) |
			(1 <= Wkcache & n > 0) |
			(DimE*DimD*DimH <= Wkcache & nnn > 0) |
			(DimE*DimD*DimH <= Wkcache & mmm > 0) ;

		int Wq_reuse= (DimE*SDD*DimH <= Wqcache & b > 0) |
			(DimE <= Wqcache & n > 0) |
			(DimE <= Wqcache & m > 0) |
			(DimE*DimD*DimH <= Wqcache & nnn > 0) |
			(DimE*DimD*DimH <= Wqcache & mmm > 0) ;//(DimE*DimD < Wqcache & m > 0) | (std::max(DimE*SNN, DimE*SMM) < Xcache & h > 0);

		int K_reuse = (1 <= Kcache & n > 0) |
			(DimD*DimH*DimB*SMM <= Kcache & nnn > 0) ;

		int V_reuse = (0);

		int Q_reuse = (SNN <= Qcache & m > 0) |
			(DimD*DimH*DimB*DimN <= Qcache & mmm > 0) ;

#endif						
			
#if(QS)	
	//Query stationary 
	for(int b = 0; b < DimB; b += SB){	
	for(int n = 0; n+nnn < std::min(DimN,nnn+SNN); n += SN){
	for(int h = 0; h < DimH; h += SH){
	for(int d = 0; d+ddd < std::min(DimD,ddd+SDD); d += SD){
	for(int m = 0; m+mmm < std::min(DimM,mmm+SMM); m += SM){
	for(int e = 0; e < DimE; e += SE){

		int X_reuse = (DimE*SMM <= Xcache & d > 0) | 
			(DimE*SMM <= Xcache & h > 0) | 
			(DimB*DimE*std::max(SNN, SMM) <= Xcache & ddd > 0) ;

		int Wk_reuse = (DimE*SDD*DimH <= Wkcache & b > 0) |
			(DimE <= Wkcache & m > 0) |
			(DimE*SDD*DimH <= Wkcache & n > 0) |
			(DimE*DimD*DimH <= Wkcache & nnn > 0) |
			(DimE*DimD*DimH <= Wkcache & mmm > 0) ;

		int Wq_reuse= (DimE*SDD*DimH <= Wqcache & b > 0) |
			(DimE <= Wqcache & n > 0) |
			(DimE*SDD*DimH <= Wqcache & m > 0) |
			(DimE*DimD*DimH <= Wqcache & nnn > 0) |
			(DimE*DimD*DimH <= Wqcache & mmm > 0) ;//(DimE*DimD < Wqcache & m > 0) | (std::max(DimE*SNN, DimE*SMM) < Xcache & h > 0);

		int K_reuse = (SDD*SMM*DimH <= Kcache & n > 0) |
			(DimD*DimH*DimB*SMM <= Kcache & nnn > 0) ;

		int V_reuse = (0);

		int Q_reuse = (1 <= Qcache & m > 0) |
			(DimD*DimH*DimB*DimN <= Qcache & mmm > 0) ;

#endif
			
	
			
			//1. All cache miss
			// std::cout << "(b "<< b<<
			// 			 ",n "<< n<<
			// 			 ",m "<< m<<
			// 			 ",h "<< h<<
			// 			 ",d "<< d<<
			// 			 ",e "<< e << std::endl;
						 
			// std::cout << "Xreuse " << X_reuse << std::endl;
			// total_en += 1;
			cycles += MULT_cyc;
			xreuse += X_reuse;
			wqreuse += Wq_reuse;
			wkreuse += Wk_reuse;
			wkreuse += Wk_reuse;
			kreuse += K_reuse;
			qreuse += Q_reuse;
			
			if(e+SE>=DimE){
				S_en += 1;
			}
			if(d+ddd+SD>=DimD){
				SM_en += 1;
				O_en += 1;
			}
			ideal_K_en += 1;
			ideal_Q_en += 1;
			ideal_V_en += 1;
			
			

			
			int cycle_round = 0;
			int reuse_round = SRAM_read_cyc;
			int round = 0;
			
			
			
			//todos
			if(K_reuse & Q_reuse){
				if(e+SE>=DimE){
					round = max(reuse_round, cycle_round);;
					total_en += 1;
				}
				
				
			}else if(K_reuse){
				total_en += 1;
				// K_en += 1;
				Q_en += 1;
				// V_en += 1;
								
				if(xreuse){
				}else{
					cycle_round +=	DRAM_read_cyc;
				}
				if(wqreuse){
				}else{
					cycle_round +=	DRAM_read_cyc;
				}
				round = max(reuse_round, cycle_round);;
			}else if(Q_reuse){
				total_en += 1;
				K_en += 1;
				// Q_en += 1;
				V_en += 1;
				
				if(xreuse){
				}else{
					cycle_round +=	DRAM_read_cyc;
				}
				if(wkreuse){
				}else{
					cycle_round +=	DRAM_read_cyc;
				}			
				round = max(reuse_round, cycle_round);;
			}else{
				K_en += 1;
				Q_en += 1;
				V_en += 1;
				total_en += 1;
				
				if(xreuse){
				}else{
					cycle_round +=	DRAM_read_cyc;
				}
				if(wqreuse){
				}else{
					cycle_round +=	DRAM_read_cyc;
				}
				if(wkreuse){
				}else{
					cycle_round +=	DRAM_read_cyc;
				}		
				round = max(reuse_round, cycle_round);;
			}
				

			
			
			actual_cycles += round;
			
			if(cycles % 10240000 == 0){
				// std::cout << "(b "<< b<<
				// 			 ",n "<< n<<
				// 			 ",m "<< m<<
				// 			 ",h "<< h<<
				// 			 ",d "<< d<<
				// 			 ",e "<< e << std::endl;
							 
				// std::cout << "Xreuse " << xreuse << std::endl;	
							
				// std::cout << "wqreuse " << wqreuse << std::endl;	
				
				// std::cout << "wkreuse " << wkreuse << std::endl;	
				
				// std::cout << "ideal_cycles" << cycles << std::endl;
				// std::cout << "actual_cycles" << actual_cycles << std::endl;
				// std::cout << "utilization" << (float) cycles / (float) actual_cycles << std::endl;
				
				
				// float util = (K_en/total_en)*RK + 
				// 			 (V_en/total_en)*RV + 
				// 			 (Q_en/total_en)*RQ + 
				// 			 (S_en/total_en)*RS + 
				// 			 (SM_en/total_en)*RSM + 
				// 			 (O_en/total_en)*RO;
				// cout << (K_en/total_en)<<endl;
			
				// std::cout << "utilization" << "("<< K_en/total_en << "," << S_en/total_en <<")" << std::endl;
				// std::cout << "util: " << util << endl;
			}
			
		// for(int bb = b; bb < std::min(bb+SB, DimB); bb++){
		// for(int nn = n; nn < std::min(nn+SN, DimN); nn++){
		// for(int hh = h; hh < std::min(hh+SH, DimH); hh++){
		// for(int mm = m; mm < std::min(mm+SM, DimM); mm++){
		// for(int dd = d; dd < std::min(dd+SD, DimD); dd++){
		// for(int ee = e; ee < std::min(ee+SE, DimE); ee++){

		
		// }}}}}}


	}}}}}}
	
	}}}
	
	//Output DRAM time, also save the KV values
	total_en += 2*(DimB*DimN*DimD*DimH)/SB/SM/SD/SH+(DimB*DimN*DimE)/SB/SN/SE;
	cycles += (2*(DimB*DimN*DimD*DimH)/SB/SM/SD/SH+(DimB*DimN*DimE)/SB/SN/SE)*DRAM_read_cyc;
	
	cout << endl;
	std::cout << "Simulation Summary" << std::endl;
	std::cout << "-----------------------" << std::endl;
	std::cout << "cycles " << cycles << std::endl;
	std::cout << "runtime " << actual_cycles/1e9 << std::endl;
	cout << "xreuse " << xreuse << endl;
	cout << "wqreuse " << wqreuse << endl;
	cout << "wkreuse "  << wkreuse << endl;
	cout << "K_reuse" << kreuse << endl;
	cout << "Q_reuse" << qreuse << endl;
	cout << endl;
	
	cout << "Q_en " <<Q_en 	<< " ("<< Q_en /total_en  <<")"<<endl;
	cout << "K_en " <<K_en 	<< " ("<< K_en /total_en  <<")"<<endl;
	cout << "V_en " <<V_en 	<< " ("<< V_en /total_en  <<")"<<endl;
	cout << "S_en " <<S_en 	<< " ("<< S_en /total_en  <<")"<<endl;
	cout << "SM_en" <<SM_en	<< " ("<< SM_en/total_en  <<")"<<endl;
	cout << "O_en " <<O_en 	<< " ("<< O_en /total_en  <<")"<<endl;
	cout << "total_en " <<total_en <<endl;
	cout << endl;
	
	cout << "TFLOP_K  " << TFLOP_K  << endl;
	cout << "TFLOP_Q  " << TFLOP_Q  << endl;
	cout << "TFLOP_V  " << TFLOP_V  << endl;
	cout << "TFLOP_S  " << TFLOP_S  << endl;
	cout << "TFLOP_SM " << TFLOP_SM << endl;
	cout << "TFLOP_O  " << TFLOP_O  << endl;
	
	cout << "TFLOPS " << (TFLOP_K + TFLOP_Q + TFLOP_V + TFLOP_S + TFLOP_SM + TFLOP_O) <<endl;
	return 0;
	
	// int SH = 1;
	// int SN = 1;
	// int SB = 1;
	// int SM = 1;
	// int SE = 64;
	// int SD = 64;
	
}


int decode_mha_systolic(){
	//A transformer / QWen1 layer (prefill)
		int dModel = 32;
		int numHeads = 2;
		int Batch = 1;
		int Seq = 2;
	
		dModel = 256;
		numHeads = 8;
		Batch = 8;
		Seq = 256;
		
		//L1 - 16x8 = 128kb
		int Kcache = 16000;
		int Vcache = 16000;
		int Qcache = 16000;
		int PScache = 16000; 
								   
		int Xcache = 16000 ;                           
		int Wkcache = 16000;                            
		int Wvcache = 16000;                           
		int Wqcache = 16000;
			
		//Memory sparsity related
		int Window = 0; //Phi() = (nn > 0)
			
		//DRAM
		int DRAM_read_cyc = 4;
		int SRAM_read_cyc = 2;
		int MULT_cyc = 1;
			
		int DimB = Batch   ;
		int DimN = 1     ;
		int DimH = numHeads    ;
		int DimM = Seq     ;
		int DimD = dModel  ;
		int DimE = dModel  ;
		
		int DimG = 10;
	
		int SH = 1;
		int SN = 1;
		int SB = 1;
		int SM = 1;
		int SE = 64;
		int SD = 64;
		
		int SNN = 16;
		int SMM = 16;
		int SDD = 64;
	
		SH = 1;SN = 1;SB = 1;SM = 1;SE = 64;SD = 64;// SO = 64;
		SNN = 16; SMM = 16; SDD = 128;
			
		// SH = 1;SN = 8;SB = 1;SM = 8;SE = 64;SD = 8;
		// SH = 2;SN = 4;SB = 1;SM = 4;SE = 64;SD = 8;
		// SH = 2;SN = 4;SB = 1;SM = 4;SE = 8;SD = 64;
		// SH = 4;SN = 4;SB = 1;SM = 4;SE = 32;SD = 8;
		// SH = 1;SN = 16;SB = 1;SM = 16;SE = 64;SD = 4;
				
		//simulator
		unsigned long long cycles = 0;
		unsigned long long actual_cycles = 0;
		unsigned long long xreuse = 0;
		unsigned long long wkreuse = 0;
		unsigned long long wqreuse = 0;
		unsigned long long kreuse = 0;
		unsigned long long qreuse = 0;
		
		double total_en = 0;
		unsigned long long K_en = 0;
		unsigned long long Q_en = 0;
		unsigned long long V_en = 0;
		unsigned long long S_en = 0;
		unsigned long long SM_en = 0;
		unsigned long long O_en = 0;
	
		
		float scale = 1e9/1e12;
		
		int TK =SD*SE*SB*SH*SM;   
		int TQ =SD*SE*SB*SH*SN;   
		int TV =SD*SE*SB*SH*SM;   
		int TS =SD*SB*SH*SM*SN;   
		int TSM=SB*SH*SM*SN;      
		int TO =  SB*SH*SM*SN*SD;
		
		int TTotal = TK+TQ+TV+TS+TSM+TO;
		
		double RK = ((double) TK )/TTotal;
		double RQ = ((double) TQ )/TTotal;
		double RV = ((double) TV )/TTotal;
		double RS = ((double) TS )/TTotal;
		double RSM= ((double) TSM)/TTotal; 
		double RO = ((double) TO )/TTotal;
		
		
		
		float TFLOP_K  =scale* SD*SE*SB*SH*SM;   
		float TFLOP_Q  =scale* SD*SE*SB*SH*SN;   
		float TFLOP_V  =scale* SD*SE*SB*SH*SM;   
		float TFLOP_S  =scale* SD*SB*SH*SM*SN;   
		float TFLOP_SM =scale* SB*SH*SM*SN;      
		float TFLOP_O  =scale*   SB*SH*SM*SN*SD;
		
		
		int orig_dimM = DimM;
		for(int g = 0; g < DimG; g += 1){
			DimM = orig_dimM + g;
		for(int nnn = 0; nnn < DimN; nnn += SNN){
		for(int mmm = 0; mmm < DimM; mmm += SMM){
		for(int ddd = 0; ddd < DimD; ddd += SDD){
	
	
	
	#if(OS)	
		//Output stationary
		//	   E D  M  N     H      B      DD    NN      MM
		//X  = 1 E  E  E   EN/EM   EN/EM  ENB/EM  EN/EM  EN/EM
		//     N R  N  N    R       N      R     N        N
		//Wq = 1 1 ED ED    ED     EDH           EDH     EDH
		//	   N N  R  R    N       R            R        R
		//Wk = 1 1 ED ED   ED      EDH           EDH     EDH
		//     N N  R  R    N       R            R        R
		//KV =   1  1 DM 
		//             R                          R         
		//Q  =      D                                     
		//          R
		//S/P= No reuse
		//     - -                                           
		for(int b = 0; b < DimB; b += SB){
		for(int h = 0; h < DimH; h += SH){
		for(int n = 0; n+nnn < std::min(DimN,nnn+SNN); n += SN){	
		for(int m = 0; m+mmm < std::min(DimM,mmm+SMM); m += SM){
		for(int d = 0; d+ddd < std::min(DimD,ddd+SDD); d += SD){
		for(int e = 0; e < DimE; e += SE){
	
				int X_reuse = (DimE <= Xcache & d > 0) | 
					(std::max(DimE*SNN, DimE*SMM) <= Xcache & h > 0) |
					(DimB*DimE*std::max(SNN, SMM) <= Xcache & ddd > 0) 
					;
				int Wk_reuse = (DimE*SDD <= Wkcache & m > 0) | (DimE*SDD <= Wkcache & n > 0) | 
					(DimE*SDD*DimH <= Wkcache & b > 0) |
					(DimE*DimD*DimH <= Wkcache & nnn > 0) |
					(DimE*DimD*DimH <= Wkcache & mmm > 0) ;
					
				int Wq_reuse= (DimE*SDD <= Wqcache & m > 0) | (DimE*SDD <= Wqcache & n > 0) | 
					(DimE*SDD*DimH <= Wqcache & b > 0) |
					(DimE*DimD*DimH <= Wqcache & nnn > 0) |
					(DimE*DimD*DimH <= Wqcache & mmm > 0) ;//(DimE*DimD < Wqcache & m > 0) | (std::max(DimE*SNN, DimE*SMM) < Xcache & h > 0);
				
				int K_reuse = (SDD*SMM <= Kcache & n > 0) |
					(DimD*DimH*DimB*SMM <= Kcache & nnn > 0) 
					;
				
				int V_reuse = (0);
				
				int Q_reuse = (SDD <= Qcache & m > 0) |
					(DimD*DimH*DimB*SMM <= Qcache & mmm > 0) 
					;
				
	#endif
	
	#if(XS)	
		//Input stationary 
		//	   D  H  E  M     N      B      DD    NN      MM
		//X  = 1  1  1  1     1      1     EMB       
		//     R  R  N  N     R      N      R     N        N
		//Wq = 1  1  1 EDH    EDH   EDH           EDH     EDH
		//	   N  N  N  R     N      R      N     N        R
		//Wk = 1 1 ED ED   ED      EDH           EDH     EDH
		//     N N  R  R    N       R            R        R
		//K  =               DHM
		// 						R                R
		//Q  =           R                                   R
	   
		for(int b = 0; b < DimB; b += SB){
		for(int n = 0; n+nnn < std::min(DimN,nnn+SNN); n += SN){	
		for(int m = 0; m+mmm < std::min(DimM,mmm+SMM); m += SM){
		for(int e = 0; e < DimE; e += SE){
		for(int h = 0; h < DimH; h += SH){
		for(int d = 0; d+ddd < std::min(DimD,ddd+SDD); d += SD){
	
			int X_reuse = (1 <= Xcache & d > 0) | 
				(1 <= Xcache & h > 0) | 
				(DimB*DimE*std::max(SNN, SMM) <= Xcache & ddd > 0) ;
	
			int Wk_reuse = (DimE*SDD*DimH <= Wkcache & b > 0) |
				(DimE*SDD*DimH <= Wkcache & m > 0) |
				(DimE*SDD*DimH <= Wkcache & n > 0) |
				(DimE*DimD*DimH <= Wkcache & nnn > 0) |
				(DimE*DimD*DimH <= Wkcache & mmm > 0) ;
	
			int Wq_reuse= (DimE*SDD*DimH <= Wqcache & b > 0) |
				(DimE*SDD*DimH <= Wqcache & n > 0) |
				(DimE*SDD*DimH <= Wqcache & m > 0) |
				(DimE*DimD*DimH <= Wqcache & nnn > 0) |
				(DimE*DimD*DimH <= Wqcache & mmm > 0) ;//(DimE*DimD < Wqcache & m > 0) | (std::max(DimE*SNN, DimE*SMM) < Xcache & h > 0);
	
			int K_reuse = (SDD*DimH*SMM <= Kcache & n > 0) |
				(DimD*DimH*DimB*SMM <= Kcache & nnn > 0) ;
	
			int V_reuse = (0);
	
			int Q_reuse = (SDD*DimH <= Qcache & m > 0) |
				(DimD*DimH*DimB*DimN <= Qcache & mmm > 0) ;
	
	#endif			
							
	#if(WS)	
		//Weight stationary 
		for(int h = 0; h < DimH; h += SH){
		for(int d = 0; d+ddd < std::min(DimD,ddd+SDD); d += SD){
		for(int e = 0; e < DimE; e += SE){
		for(int b = 0; b < DimB; b += SB){
		for(int n = 0; n+nnn < std::min(DimN,nnn+SNN); n += SN){	
		for(int m = 0; m+mmm < std::min(DimM,mmm+SMM); m += SM){
	
			int X_reuse = (DimB*DimE*std::max(SNN, SMM) <= Xcache & d > 0) | 
				(DimB*DimE*std::max(SNN, SMM) <= Xcache & h > 0) | 
				(DimB*DimE*std::max(SNN, SMM) <= Xcache & ddd > 0) ;
	
			int Wk_reuse = (1 <= Wkcache & b > 0) |
				(1 <= Wkcache & m > 0) |
				(1 <= Wkcache & n > 0) |
				(DimE*DimD*DimH <= Wkcache & nnn > 0) |
				(DimE*DimD*DimH <= Wkcache & mmm > 0) ;
	
			int Wq_reuse= (1 <= Wqcache & b > 0) |
				(1 <= Wqcache & n > 0) |
				(1 <= Wqcache & m > 0) |
				(DimE*DimD*DimH <= Wqcache & nnn > 0) |
				(DimE*DimD*DimH <= Wqcache & mmm > 0) ;//(DimE*DimD < Wqcache & m > 0) | (std::max(DimE*SNN, DimE*SMM) < Xcache & h > 0);
	
			int K_reuse = (SMM <= Kcache & n > 0) |
				(DimD*DimH*DimB*SMM <= Kcache & nnn > 0) ;
	
			int V_reuse = (0);
	
			int Q_reuse = (1 <= Qcache & m > 0) |
				(DimD*DimH*DimB*DimN <= Qcache & mmm > 0) ;
	
	#endif			
								
				
	#if(KS)	
		//Key stationary 
		for(int b = 0; b < DimB; b += SB){		
		for(int d = 0; d+ddd < std::min(DimD,ddd+SDD); d += SD){
		for(int h = 0; h < DimH; h += SH){
		for(int m = 0; m+mmm < std::min(DimM,mmm+SMM); m += SM){
		for(int n = 0; n+nnn < std::min(DimN,nnn+SNN); n += SN){
		for(int e = 0; e < DimE; e += SE){
	
			int X_reuse = (DimB*DimE*std::max(SNN, SMM) <= Xcache & d > 0) | 
				(DimB*DimE*std::max(SNN, SMM) <= Xcache & h > 0) | 
				(DimB*DimE*std::max(SNN, SMM) <= Xcache & ddd > 0) ;
	
			int Wk_reuse = (1 <= Wkcache & b > 0) |
				(1 <= Wkcache & m > 0) |
				(1 <= Wkcache & n > 0) |
				(DimE*DimD*DimH <= Wkcache & nnn > 0) |
				(DimE*DimD*DimH <= Wkcache & mmm > 0) ;
	
			int Wq_reuse= (DimE*SDD*DimH <= Wqcache & b > 0) |
				(DimE <= Wqcache & n > 0) |
				(DimE <= Wqcache & m > 0) |
				(DimE*DimD*DimH <= Wqcache & nnn > 0) |
				(DimE*DimD*DimH <= Wqcache & mmm > 0) ;//(DimE*DimD < Wqcache & m > 0) | (std::max(DimE*SNN, DimE*SMM) < Xcache & h > 0);
	
			int K_reuse = (1 <= Kcache & n > 0) |
				(DimD*DimH*DimB*SMM <= Kcache & nnn > 0) ;
	
			int V_reuse = (0);
	
			int Q_reuse = (SNN <= Qcache & m > 0) |
				(DimD*DimH*DimB*DimN <= Qcache & mmm > 0) ;
	
	#endif						
				
	#if(QS)	
		//Query stationary 
		for(int b = 0; b < DimB; b += SB){	
		for(int n = 0; n+nnn < std::min(DimN,nnn+SNN); n += SN){
		for(int h = 0; h < DimH; h += SH){
		for(int d = 0; d+ddd < std::min(DimD,ddd+SDD); d += SD){
		for(int m = 0; m+mmm < std::min(DimM,mmm+SMM); m += SM){
		for(int e = 0; e < DimE; e += SE){
	
			int X_reuse = (DimE*SMM <= Xcache & d > 0) | 
				(DimE*SMM <= Xcache & h > 0) | 
				(DimB*DimE*std::max(SNN, SMM) <= Xcache & ddd > 0) ;
	
			int Wk_reuse = (DimE*SDD*DimH <= Wkcache & b > 0) |
				(DimE <= Wkcache & m > 0) |
				(DimE*SDD*DimH <= Wkcache & n > 0) |
				(DimE*DimD*DimH <= Wkcache & nnn > 0) |
				(DimE*DimD*DimH <= Wkcache & mmm > 0) ;
	
			int Wq_reuse= (DimE*SDD*DimH <= Wqcache & b > 0) |
				(DimE <= Wqcache & n > 0) |
				(DimE*SDD*DimH <= Wqcache & m > 0) |
				(DimE*DimD*DimH <= Wqcache & nnn > 0) |
				(DimE*DimD*DimH <= Wqcache & mmm > 0) ;//(DimE*DimD < Wqcache & m > 0) | (std::max(DimE*SNN, DimE*SMM) < Xcache & h > 0);
	
			int K_reuse = (SDD*SMM*DimH <= Kcache & n > 0) |
				(DimD*DimH*DimB*SMM <= Kcache & nnn > 0) ;
	
			int V_reuse = (0);
	
			int Q_reuse = (1 <= Qcache & m > 0) |
				(DimD*DimH*DimB*DimN <= Qcache & mmm > 0) ;
	
	#endif
				
		
				
				//1. All cache miss
				// std::cout << "(b "<< b<<
				// 			 ",n "<< n<<
				// 			 ",m "<< m<<
				// 			 ",h "<< h<<
				// 			 ",d "<< d<<
				// 			 ",e "<< e << std::endl;
							 
				// std::cout << "Xreuse " << X_reuse << std::endl;
				total_en += 1;
				cycles += MULT_cyc;
				xreuse += X_reuse;
				wqreuse += Wq_reuse;
				wkreuse += Wk_reuse;
				wkreuse += Wk_reuse;
				kreuse += K_reuse;
				qreuse += Q_reuse;
				
				if(e+SE>=DimE){
					S_en += 1;
				}
				if(d+SD>=DimD){
					SM_en += 1;
					O_en += 1;
				}
				K_en += 1;
				Q_en += 1;
				V_en += 1;
				
				
				
				
				int cycle_round = 0;
				int reuse_round = SRAM_read_cyc;
				int round = 0;
				//K cache
				int KCache_hit = !(SMM+mmm >= DimM);  
				if(KCache_hit){
					//If cache hit, fetch K_reuse == 1
					K_reuse = 1;
				}
				
				if(K_reuse & Q_reuse){
					if(e+SE>=DimE){
						round = max(reuse_round, cycle_round);;
					}
				}else if(K_reuse){
					if(xreuse){
					}else{
						cycle_round +=	DRAM_read_cyc;
					}
					if(wqreuse){
					}else{
						cycle_round +=	DRAM_read_cyc;
					}
					round = max(reuse_round, cycle_round);;
				}else if(Q_reuse){
					if(xreuse){
					}else{
						cycle_round +=	DRAM_read_cyc;
					}
					if(wkreuse){
					}else{
						cycle_round +=	DRAM_read_cyc;
					}			
					round = max(reuse_round, cycle_round);;
				}else{
					if(xreuse){
					}else{
						cycle_round +=	DRAM_read_cyc;
					}
					if(wqreuse){
					}else{
						cycle_round +=	DRAM_read_cyc;
					}
					if(wkreuse){
					}else{
						cycle_round +=	DRAM_read_cyc;
					}		
					round = max(reuse_round, cycle_round);;
				}
				
	
				
				
				actual_cycles += round;
				
				if(cycles % 10240000 == 0){
					// std::cout << "(b "<< b<<
					// 			 ",n "<< n<<
					// 			 ",m "<< m<<
					// 			 ",h "<< h<<
					// 			 ",d "<< d<<
					// 			 ",e "<< e << std::endl;
								 
					// std::cout << "Xreuse " << xreuse << std::endl;	
								
					// std::cout << "wqreuse " << wqreuse << std::endl;	
					
					// std::cout << "wkreuse " << wkreuse << std::endl;	
					
					// std::cout << "ideal_cycles" << cycles << std::endl;
					// std::cout << "actual_cycles" << actual_cycles << std::endl;
					// std::cout << "utilization" << (float) cycles / (float) actual_cycles << std::endl;
					
					
					float util = (K_en/total_en)*RK + 
								 (V_en/total_en)*RV + 
								 (Q_en/total_en)*RQ + 
								 (S_en/total_en)*RS + 
								 (SM_en/total_en)*RSM + 
								 (O_en/total_en)*RO;
					// cout << (K_en/total_en)<<endl;
				
					// std::cout << "utilization" << "("<< K_en/total_en << "," << S_en/total_en <<")" << std::endl;
					// std::cout << "util: " << util << endl;
				}
				
			// for(int bb = b; bb < std::min(bb+SB, DimB); bb++){
			// for(int nn = n; nn < std::min(nn+SN, DimN); nn++){
			// for(int hh = h; hh < std::min(hh+SH, DimH); hh++){
			// for(int mm = m; mm < std::min(mm+SM, DimM); mm++){
			// for(int dd = d; dd < std::min(dd+SD, DimD); dd++){
			// for(int ee = e; ee < std::min(ee+SE, DimE); ee++){
	
			
			// }}}}}}
	
	
		}}}}}}
		
		}}}
		
		}
		
		cout << endl;
		std::cout << "Simulation Summary" << std::endl;
		std::cout << "-----------------------" << std::endl;
		std::cout << "cycles " << cycles << std::endl;
		std::cout << "runtime " << actual_cycles/1e9 << std::endl;
		cout << "xreuse " << xreuse << endl;
		cout << "wqreuse " << wqreuse << endl;
		cout << "wkreuse "  << wkreuse << endl;
		cout << "K_reuse" << kreuse << endl;
		cout << "Q_reuse" << qreuse << endl;
		
		cout << "TFLOP_K  " << TFLOP_K  << endl;
		cout << "TFLOP_Q  " << TFLOP_Q  << endl;
		cout << "TFLOP_V  " << TFLOP_V  << endl;
		cout << "TFLOP_S  " << TFLOP_S  << endl;
		cout << "TFLOP_SM " << TFLOP_SM << endl;
		cout << "TFLOP_O  " << TFLOP_O  << endl;
		
		cout << "TFLOPS " << (TFLOP_K + TFLOP_Q + TFLOP_V + TFLOP_S + TFLOP_SM + TFLOP_O) <<endl;
		return 0;
		
		// int SH = 1;
		// int SN = 1;
		// int SB = 1;
		// int SM = 1;
		// int SE = 64;
		// int SD = 64;
		
}



int prefill_mha_systolic(){
	//A transformer / QWen1 layer (prefill)
	int dModel = 32;
	int numHeads = 2;
	int Batch = 1;
	int Seq = 2;

	dModel = 256;
	numHeads = 8;
	Batch = 8;
	Seq = 256;
	
	//L1 - 16x8 = 128kb
	int cache = 16000;
	
	// #if(CACHE)
	// 	cache = CACHE;
	// #endif
	
	int Kcache  = cache;
	int Vcache  = cache;
	int Qcache  = cache;
	int PScache = cache; 	   
	int Xcache  = cache ;                           
	int Wkcache = cache;                            
	int Wvcache = cache;                           
	int Wqcache = cache;
		
	//Memory sparsity related
	int Window = 0; //Phi() = (nn > 0)
		
	//DRAM
	int DRAM_read_cyc = 4;
	int SRAM_read_cyc = 2;
	int MULT_cyc = 1;
		
	int DimB = Batch   ;
	int DimN = Seq     ;
	int DimH = numHeads    ;
	int DimM = Seq     ;
	int DimD = dModel  ;
	int DimE = dModel  ;

	int SH = 1;
	int SN = 1;
	int SB = 1;
	int SM = 1;
	int SE = 64;
	int SD = 64;
	
	int SNN = 16;
	int SMM = 16;
	int SDD = 64;

	//Focus on embedding
	#if(TILE1)
	SH = 1;SN = 1;SB = 1;SM = 1;SE = 64;SD = 64;// SO = 64;
	SNN = 64; SMM = 64; SDD = 128;
	#endif
	
	
	#if(TILE2)
	// //Focus embedding + Softmax
	SH = 1;SN = 64;SB = 1;SM = 32;SE = 64;SD = 1;// SO = 64;
	SNN = 128; SMM = 128; SDD = 128;
	#endif

	#if(TILE3)
	// //Focus on softmax
	SH = 1;SN = 12;SB = 1;SM = 8;SE = 1;SD = 64;// SO = 64;
	SNN = 64; SMM = 64; SDD = 128;
	#endif
	
	#if(TILE4)
	// //Focus on heads
	SH = 4;SN = 12;SB = 1;SM = 8;SE = 1;SD = 16;// SO = 64;
	SNN = 64; SMM = 64; SDD = 128;
	#endif
	
	#if(TILE5)
	// //Focus on balanced
	SH = 1;SN = 16;SB = 4;SM = 16;SE = 4;SD = 4;// SO = 64;
	SNN = 64; SMM = 64; SDD = 128;
	#endif

	#if(TILE6)
	// //Focus on balanced
	SH = 4;SN = 16;SB = 1;SM = 16;SE = 64;SD = 1;// SO = 64;
	SNN = 64; SMM = 64; SDD = 128;
	#endif
	
	
	#if(TILE7)
	// //Focus on balanced
	SH = 1;SN = 16;SB = 1;SM = 16;SE = 16;SD = 8;// SO = 64;
	SNN = 64; SMM = 64; SDD = 128;
	#endif
								
	// SH = 1;SN = 8;SB = 1;SM = 8;SE = 64;SD = 8;
	// SH = 2;SN = 4;SB = 1;SM = 4;SE = 64;SD = 8;
	// SH = 2;SN = 4;SB = 1;SM = 4;SE = 8;SD = 64;
	// SH = 4;SN = 4;SB = 1;SM = 4;SE = 32;SD = 8;
	// SH = 1;SN = 16;SB = 1;SM = 16;SE = 64;SD = 4;
			
	//simulator
	unsigned long long cycles = 0;
	unsigned long long actual_cycles = 0;
	unsigned long long xreuse = 0;
	unsigned long long wkreuse = 0;
	unsigned long long wqreuse = 0;
	unsigned long long kreuse = 0;
	unsigned long long qreuse = 0;
	
	double total_en = 0;
	unsigned long long K_en  = 0;
	unsigned long long Q_en  = 0;
	unsigned long long V_en  = 0;
	unsigned long long S_en  = 0;
	unsigned long long SM_en  = 0;
	unsigned long long O_en  = 0;

	unsigned long long ideal_K_en  = 0;
	unsigned long long ideal_Q_en  = 0;
	unsigned long long ideal_V_en  = 0;
	unsigned long long ideal_S_en  = 0;
	unsigned long long ideal_SM_en  = 0;
	unsigned long long ideal_O_en  = 0;
	
	float scale = 1e9/1e12;
	
	int TK =SD*SE*SB*SH*SM;   
	int TQ =SD*SE*SB*SH*SN;   
	int TV =SD*SE*SB*SH*SM;   
	int TS =SD*SB*SH*SM*SN;   
	int TSM=SB*SH*SM*SN;      
	int TO =  SB*SH*SM*SN*SD;
	
	int TTotal = TK+TQ+TV+TS+TSM+TO;
	
	double RK = ((double) TK )/TTotal;
	double RQ = ((double) TQ )/TTotal;
	double RV = ((double) TV )/TTotal;
	double RS = ((double) TS )/TTotal;
	double RSM= ((double) TSM)/TTotal; 
	double RO = ((double) TO )/TTotal;
	
	
	
	float TFLOP_K  =scale* SD*SE*SB*SH*SM;   
	float TFLOP_Q  =scale* SD*SE*SB*SH*SN;   
	float TFLOP_V  =scale* SD*SE*SB*SH*SM;   
	float TFLOP_S  =scale* SD*SB*SH*SM*SN;   
	float TFLOP_SM =scale* SB*SH*SM*SN;      
	float TFLOP_O  =scale*   SB*SH*SM*SN*SD;
	
	
	
	
		
	for(int nnn = 0; nnn < DimN; nnn += SNN){
	for(int mmm = 0; mmm < DimM; mmm += SMM){
	for(int ddd = 0; ddd < DimD; ddd += SDD){



#if(OS)	
	//Output stationary
	//	   E D  M  N     H      B      DD    NN      MM
	//X  = 1 E  E  E   EN/EM   EN/EM  ENB/EM  EN/EM  EN/EM
	//     N R  N  N    R       N      R     N        N
	//Wq = 1 1 ED ED    ED     EDH           EDH     EDH
	//	   N N  R  R    N       R            R        R
	//Wk = 1 1 ED ED   ED      EDH           EDH     EDH
	//     N N  R  R    N       R            R        R
	//KV =   1  1 DM 
	//             R                          R         
	//Q  =      D                                     
	//          R
	//S/P= No reuse
	//     - -                                           
	for(int b = 0; b < DimB; b += SB){
	for(int h = 0; h < DimH; h += SH){
	for(int n = 0; n+nnn < std::min(DimN,nnn+SNN); n += SN){	
	for(int m = 0; m+mmm < std::min(DimM,mmm+SMM); m += SM){
	for(int d = 0; d+ddd < std::min(DimD,ddd+SDD); d += SD){
	for(int e = 0; e < DimE; e += SE){

			int X_reuse = (DimE <= Xcache & d > 0) | 
				(std::max(DimE*SNN, DimE*SMM) <= Xcache & h > 0) |
				(DimB*DimE*std::max(SNN, SMM) <= Xcache & ddd > 0) 
				;
			int Wk_reuse = (DimE*SDD <= Wkcache & m > 0) | (DimE*SDD <= Wkcache & n > 0) | 
				(DimE*SDD*DimH <= Wkcache & b > 0) |
				(DimE*DimD*DimH <= Wkcache & nnn > 0) |
				(DimE*DimD*DimH <= Wkcache & mmm > 0) ;
				
			int Wq_reuse= (DimE*SDD <= Wqcache & m > 0) | (DimE*SDD <= Wqcache & n > 0) | 
				(DimE*SDD*DimH <= Wqcache & b > 0) |
				(DimE*DimD*DimH <= Wqcache & nnn > 0) |
				(DimE*DimD*DimH <= Wqcache & mmm > 0) ;//(DimE*DimD < Wqcache & m > 0) | (std::max(DimE*SNN, DimE*SMM) < Xcache & h > 0);
			
			int K_reuse = (SDD*SMM <= Kcache & n > 0) |
				(DimD*DimH*DimB*SMM <= Kcache & nnn > 0) 
				;
			
			int V_reuse = (0);
			
			int Q_reuse = (SDD <= Qcache & m > 0) |
				(DimD*DimH*DimB*SMM <= Qcache & mmm > 0) 
				;
			
#endif

#if(XS)	
	//Input stationary 
	//	   D  H  E  M     N      B      DD    NN      MM
	//X  = 1  1  1  1     1      1     EMB       
	//     R  R  N  N     R      N      R     N        N
	//Wq = 1  1  1 EDH    EDH   EDH           EDH     EDH
	//	   N  N  N  R     N      R      N     N        R
	//Wk = 1 1 ED ED   ED      EDH           EDH     EDH
	//     N N  R  R    N       R            R        R
	//K  =               DHM
	// 						R                R
	//Q  =           R                                   R
   
	for(int b = 0; b < DimB; b += SB){
	for(int n = 0; n+nnn < std::min(DimN,nnn+SNN); n += SN){	
	for(int m = 0; m+mmm < std::min(DimM,mmm+SMM); m += SM){
	for(int e = 0; e < DimE; e += SE){
	for(int h = 0; h < DimH; h += SH){
	for(int d = 0; d+ddd < std::min(DimD,ddd+SDD); d += SD){

		int X_reuse = (1 <= Xcache & d > 0) | 
			(1 <= Xcache & h > 0) | 
			(DimB*DimE*std::max(SNN, SMM) <= Xcache & ddd > 0) ;

		int Wk_reuse = (DimE*SDD*DimH <= Wkcache & b > 0) |
			(DimE*SDD*DimH <= Wkcache & m > 0) |
			(DimE*SDD*DimH <= Wkcache & n > 0) |
			(DimE*DimD*DimH <= Wkcache & nnn > 0) |
			(DimE*DimD*DimH <= Wkcache & mmm > 0) ;

		int Wq_reuse= (DimE*SDD*DimH <= Wqcache & b > 0) |
			(DimE*SDD*DimH <= Wqcache & n > 0) |
			(DimE*SDD*DimH <= Wqcache & m > 0) |
			(DimE*DimD*DimH <= Wqcache & nnn > 0) |
			(DimE*DimD*DimH <= Wqcache & mmm > 0) ;//(DimE*DimD < Wqcache & m > 0) | (std::max(DimE*SNN, DimE*SMM) < Xcache & h > 0);

		int K_reuse = (SDD*DimH*SMM <= Kcache & n > 0) |
			(DimD*DimH*DimB*SMM <= Kcache & nnn > 0) ;

		int V_reuse = (0);

		int Q_reuse = (SDD*DimH <= Qcache & m > 0) |
			(DimD*DimH*DimB*DimN <= Qcache & mmm > 0) ;

#endif			
						
#if(WS)	
	//Weight stationary 
	for(int h = 0; h < DimH; h += SH){
	for(int d = 0; d+ddd < std::min(DimD,ddd+SDD); d += SD){
	for(int e = 0; e < DimE; e += SE){
	for(int b = 0; b < DimB; b += SB){
	for(int n = 0; n+nnn < std::min(DimN,nnn+SNN); n += SN){	
	for(int m = 0; m+mmm < std::min(DimM,mmm+SMM); m += SM){

		int X_reuse = (DimB*DimE*std::max(SNN, SMM) <= Xcache & d > 0) | 
			(DimB*DimE*std::max(SNN, SMM) <= Xcache & h > 0) | 
			(DimB*DimE*std::max(SNN, SMM) <= Xcache & ddd > 0) ;

		int Wk_reuse = (1 <= Wkcache & b > 0) |
			(1 <= Wkcache & m > 0) |
			(1 <= Wkcache & n > 0) |
			(DimE*DimD*DimH <= Wkcache & nnn > 0) |
			(DimE*DimD*DimH <= Wkcache & mmm > 0) ;

		int Wq_reuse= (1 <= Wqcache & b > 0) |
			(1 <= Wqcache & n > 0) |
			(1 <= Wqcache & m > 0) |
			(DimE*DimD*DimH <= Wqcache & nnn > 0) |
			(DimE*DimD*DimH <= Wqcache & mmm > 0) ;//(DimE*DimD < Wqcache & m > 0) | (std::max(DimE*SNN, DimE*SMM) < Xcache & h > 0);

		int K_reuse = (SMM <= Kcache & n > 0) |
			(DimD*DimH*DimB*SMM <= Kcache & nnn > 0) ;

		int V_reuse = (0);

		int Q_reuse = (1 <= Qcache & m > 0) |
			(DimD*DimH*DimB*DimN <= Qcache & mmm > 0) ;

#endif			
							
			
#if(KS)	
	//Key stationary 
	for(int b = 0; b < DimB; b += SB){		
	for(int d = 0; d+ddd < std::min(DimD,ddd+SDD); d += SD){
	for(int h = 0; h < DimH; h += SH){
	for(int m = 0; m+mmm < std::min(DimM,mmm+SMM); m += SM){
	for(int n = 0; n+nnn < std::min(DimN,nnn+SNN); n += SN){
	for(int e = 0; e < DimE; e += SE){

		int X_reuse = (DimB*DimE*std::max(SNN, SMM) <= Xcache & d > 0) | 
			(DimB*DimE*std::max(SNN, SMM) <= Xcache & h > 0) | 
			(DimB*DimE*std::max(SNN, SMM) <= Xcache & ddd > 0) ;

		int Wk_reuse = (1 <= Wkcache & b > 0) |
			(1 <= Wkcache & m > 0) |
			(1 <= Wkcache & n > 0) |
			(DimE*DimD*DimH <= Wkcache & nnn > 0) |
			(DimE*DimD*DimH <= Wkcache & mmm > 0) ;

		int Wq_reuse= (DimE*SDD*DimH <= Wqcache & b > 0) |
			(DimE <= Wqcache & n > 0) |
			(DimE <= Wqcache & m > 0) |
			(DimE*DimD*DimH <= Wqcache & nnn > 0) |
			(DimE*DimD*DimH <= Wqcache & mmm > 0) ;//(DimE*DimD < Wqcache & m > 0) | (std::max(DimE*SNN, DimE*SMM) < Xcache & h > 0);

		int K_reuse = (1 <= Kcache & n > 0) |
			(DimD*DimH*DimB*SMM <= Kcache & nnn > 0) ;

		int V_reuse = (0);

		int Q_reuse = (SNN <= Qcache & m > 0) |
			(DimD*DimH*DimB*DimN <= Qcache & mmm > 0) ;

#endif						
			
#if(QS)	
	//Query stationary 
	for(int b = 0; b < DimB; b += SB){	
	for(int n = 0; n+nnn < std::min(DimN,nnn+SNN); n += SN){
	for(int h = 0; h < DimH; h += SH){
	for(int d = 0; d+ddd < std::min(DimD,ddd+SDD); d += SD){
	for(int m = 0; m+mmm < std::min(DimM,mmm+SMM); m += SM){
	for(int e = 0; e < DimE; e += SE){

		int X_reuse = (DimE*SMM <= Xcache & d > 0) | 
			(DimE*SMM <= Xcache & h > 0) | 
			(DimB*DimE*std::max(SNN, SMM) <= Xcache & ddd > 0) ;

		int Wk_reuse = (DimE*SDD*DimH <= Wkcache & b > 0) |
			(DimE <= Wkcache & m > 0) |
			(DimE*SDD*DimH <= Wkcache & n > 0) |
			(DimE*DimD*DimH <= Wkcache & nnn > 0) |
			(DimE*DimD*DimH <= Wkcache & mmm > 0) ;

		int Wq_reuse= (DimE*SDD*DimH <= Wqcache & b > 0) |
			(DimE <= Wqcache & n > 0) |
			(DimE*SDD*DimH <= Wqcache & m > 0) |
			(DimE*DimD*DimH <= Wqcache & nnn > 0) |
			(DimE*DimD*DimH <= Wqcache & mmm > 0) ;//(DimE*DimD < Wqcache & m > 0) | (std::max(DimE*SNN, DimE*SMM) < Xcache & h > 0);

		int K_reuse = (SDD*SMM*DimH <= Kcache & n > 0) |
			(DimD*DimH*DimB*SMM <= Kcache & nnn > 0) ;

		int V_reuse = (0);

		int Q_reuse = (1 <= Qcache & m > 0) |
			(DimD*DimH*DimB*DimN <= Qcache & mmm > 0) ;

#endif
			
	
			
			//1. All cache miss
			// std::cout << "(b "<< b<<
			// 			 ",n "<< n<<
			// 			 ",m "<< m<<
			// 			 ",h "<< h<<
			// 			 ",d "<< d<<
			// 			 ",e "<< e << std::endl;
						 
			// std::cout << "Xreuse " << X_reuse << std::endl;
			// total_en += 1;
			cycles += MULT_cyc;
			xreuse += X_reuse;
			wqreuse += Wq_reuse;
			wkreuse += Wk_reuse;
			wkreuse += Wk_reuse;
			kreuse += K_reuse;
			qreuse += Q_reuse;
			
			if(e+SE>=DimE){
				S_en += 1;
			}
			if(d+ddd+SD>=DimD){
				SM_en += 1;
				O_en += 1;
			}
			ideal_K_en += 1;
			ideal_Q_en += 1;
			ideal_V_en += 1;
			
			

			
			int cycle_round = 0;
			int reuse_round = SRAM_read_cyc;
			int round = 0;
			
			
			
			//todos
			if(K_reuse & Q_reuse){
				if(e+SE>=DimE){
					round = max(reuse_round, cycle_round);;
					total_en += 1;
				}
				
				
			}else if(K_reuse){
				total_en += 1;
				// K_en += 1;
				Q_en += 1;
				// V_en += 1;
								
				if(xreuse){
				}else{
					cycle_round +=	DRAM_read_cyc;
				}
				if(wqreuse){
				}else{
					cycle_round +=	DRAM_read_cyc;
				}
				round = max(reuse_round, cycle_round);;
			}else if(Q_reuse){
				total_en += 1;
				K_en += 1;
				// Q_en += 1;
				V_en += 1;
				
				if(xreuse){
				}else{
					cycle_round +=	DRAM_read_cyc;
				}
				if(wkreuse){
				}else{
					cycle_round +=	DRAM_read_cyc;
				}			
				round = max(reuse_round, cycle_round);;
			}else{
				K_en += 1;
				Q_en += 1;
				V_en += 1;
				total_en += 1;
				
				if(xreuse){
				}else{
					cycle_round +=	DRAM_read_cyc;
				}
				if(wqreuse){
				}else{
					cycle_round +=	DRAM_read_cyc;
				}
				if(wkreuse){
				}else{
					cycle_round +=	DRAM_read_cyc;
				}		
				round = max(reuse_round, cycle_round);;
			}
				

			
			
			actual_cycles += round;
			
			if(cycles % 10240000 == 0){
				// std::cout << "(b "<< b<<
				// 			 ",n "<< n<<
				// 			 ",m "<< m<<
				// 			 ",h "<< h<<
				// 			 ",d "<< d<<
				// 			 ",e "<< e << std::endl;
							 
				// std::cout << "Xreuse " << xreuse << std::endl;	
							
				// std::cout << "wqreuse " << wqreuse << std::endl;	
				
				// std::cout << "wkreuse " << wkreuse << std::endl;	
				
				// std::cout << "ideal_cycles" << cycles << std::endl;
				// std::cout << "actual_cycles" << actual_cycles << std::endl;
				// std::cout << "utilization" << (float) cycles / (float) actual_cycles << std::endl;
				
				
				float util = (K_en/total_en)*RK + 
							 (V_en/total_en)*RV + 
							 (Q_en/total_en)*RQ + 
							 (S_en/total_en)*RS + 
							 (SM_en/total_en)*RSM + 
							 (O_en/total_en)*RO;
				// cout << (K_en/total_en)<<endl;
			
				// std::cout << "utilization" << "("<< K_en/total_en << "," << S_en/total_en <<")" << std::endl;
				// std::cout << "util: " << util << endl;
			}
			
		// for(int bb = b; bb < std::min(bb+SB, DimB); bb++){
		// for(int nn = n; nn < std::min(nn+SN, DimN); nn++){
		// for(int hh = h; hh < std::min(hh+SH, DimH); hh++){
		// for(int mm = m; mm < std::min(mm+SM, DimM); mm++){
		// for(int dd = d; dd < std::min(dd+SD, DimD); dd++){
		// for(int ee = e; ee < std::min(ee+SE, DimE); ee++){

		
		// }}}}}}


	}}}}}}
	
	}}}
	
	//Output DRAM time, also save the KV values
	total_en += 2*(DimB*DimN*DimD*DimH)/SB/SM/SD/SH+(DimB*DimN*DimE)/SB/SN/SE;
	cycles += (2*(DimB*DimN*DimD*DimH)/SB/SM/SD/SH+(DimB*DimN*DimE)/SB/SN/SE)*DRAM_read_cyc;
	
	cout << endl;
	std::cout << "Simulation Summary" << std::endl;
	std::cout << "-----------------------" << std::endl;
	std::cout << "cycles " << cycles << std::endl;
	std::cout << "runtime " << actual_cycles/1e9 << std::endl;
	cout << "xreuse " << xreuse << endl;
	cout << "wqreuse " << wqreuse << endl;
	cout << "wkreuse "  << wkreuse << endl;
	cout << "K_reuse" << kreuse << endl;
	cout << "Q_reuse" << qreuse << endl;
	cout << endl;
	
	cout << "Q_en " <<Q_en 	<< " ("<< Q_en /total_en  <<")"<<endl;
	cout << "K_en " <<K_en 	<< " ("<< K_en /total_en  <<")"<<endl;
	cout << "V_en " <<V_en 	<< " ("<< V_en /total_en  <<")"<<endl;
	cout << "S_en " <<S_en 	<< " ("<< S_en /total_en  <<")"<<endl;
	cout << "SM_en" <<SM_en	<< " ("<< SM_en/total_en  <<")"<<endl;
	cout << "O_en " <<O_en 	<< " ("<< O_en /total_en  <<")"<<endl;
	cout << "total_en " <<total_en <<endl;
	cout << endl;
	
	cout << "TFLOP_K  " << TFLOP_K  << endl;
	cout << "TFLOP_Q  " << TFLOP_Q  << endl;
	cout << "TFLOP_V  " << TFLOP_V  << endl;
	cout << "TFLOP_S  " << TFLOP_S  << endl;
	cout << "TFLOP_SM " << TFLOP_SM << endl;
	cout << "TFLOP_O  " << TFLOP_O  << endl;
	
	cout << "TFLOPS " << (TFLOP_K + TFLOP_Q + TFLOP_V + TFLOP_S + TFLOP_SM + TFLOP_O) <<endl;
	return 0;
	
	// int SH = 1;
	// int SN = 1;
	// int SB = 1;
	// int SM = 1;
	// int SE = 64;
	// int SD = 64;
	
}




int main(){
	
	#if(MHAD)
	
		decode_mha_systolic();
	
	#endif
	
	
	#if(MHAP)
	prefill_mha_systolic();
	
	#endif
	
	#if(MHASPP)
	prefill_mha_sparsity();
	#endif
}