
#include <algorithm>
#include <iostream>
using namespace std;
#include <cmath>
#include <iostream>
#include <sstream>
#include <string>

#include <tuple>
#include <string>


#include <iostream>
#include <utility>
//Everything computed in serial, because can only do so. (BinaryLLM)
//Support caching
//Singular Fused-Operator,  KGen -> SRAM, VGen -> SRAM
//V1 - Homogenous tiling

struct SimResult {
    string design;
    string label;
};


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

	dModel = 256;
	numHeads = 4;
	Batch = 4;
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
	int sparse_type = 1;
	
	
	
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

		dModel = 1024;
		numHeads = 16;
		Batch = 4;
		Seq = 256;
			

	dModel = 256;
	numHeads = 4;
	Batch = 4;
	Seq = 16000;
	
	
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
	
	//Focus on embedding
	#if(TILE1)
	SH = 1;SN = 1;SB = 1;SM = 1;SE = 128;SD = 64;// SO = 64;
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
	
	// #if(TILE4)
	// // //Focus on heads
	// SH = 4;SN = 12;SB = 1;SM = 8;SE = 1;SD = 16;// SO = 64;
	// SNN = 64; SMM = 64; SDD = 128;
	// #endif

	//Batched?
	#if(TILE4)
	SH = 1;SN = 1;SB = 4;SM = 1;SE = 32;SD = 32;// SO = 64;
	SNN = 64; SMM = 64; SDD = 128;
	#endif
	
	// #if(TILE4)
	// SH = 1;SN = 1;SB = 2;SM = 2;SE = 64;SD = 32;// SO = 64;
	// SNN = 64; SMM = 64; SDD = 128;
	// #endif	
	
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






//Everything computed in serial, because can only do so. (BinaryLLM)
//Support caching
//Singular Fused-Operator,  KGen -> SRAM, VGen -> SRAM
int prefill_mha_baseline(
	int SG , 
	int SB ,
	int SN ,
	int SI ,
	
	int SM_SB ,
	int SM_SN ,
	int SM_SM ,
	
	
	int PhiX,
	int PhiW
	
){
	cout << "prefill_mha_baseline" << endl;
	//A transformer / QWen1 layer (prefill)
	int dModel = 32;
	int numHeads = 2;
	int Batch = 1;
	int Seq = 2;
	
	
	dModel = 1024;
	numHeads = 16;
	Batch = 4;
	Seq = SEQ;//SEQ=1024
	
	dModel = DMODEL; //1024
	numHeads = HEADS; //16
	Batch = BATCH;//4
	Seq = SEQ;//SEQ=1024
	
	//L1 - 16x8 = 128kb
	int cache = CACHE;
	
	//MM
	int Xcache = cache;
	int Wcache = cache;
	
	//Softmax
	int Scache = cache;
	
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
		
			
						#if(DECODE)
						
						DimB = Batch   ;
						DimN = 1     ;
						DimH = numHeads    ;
						DimM = Seq     ;
						DimD = dModel  ;
						DimE = dModel  ;


						#endif
						
						
	///////////////////////////////////////
	//matrix multiply
	// int SG = 1; 
	// int SB = 1;
	// int SN = 64;
	// int SI = 64;
	
	// int SM_SB = 16;
	// int SM_SN = 16;
	// int SM_SM = 16;
	
	int MM_SBB = TILING;
	int MM_SGG = TILING;
	int MM_SNN = TILING;
	
	//softmax
	// int SM_SB = 16;
	// int SM_SN = 16;
	// int SM_SM = 16;
	
	int SM_SNN = TILING;
	int SM_SMM = TILING;
	////////////////////////////////////////
	
	// #if(TILE1)
	// 	SG = 1; SB = 128; SN = 64; SI = 1;
	// 	SM_SB = 1;SM_SN=64; SM_SM=64;
	// #endif
	
	// #if(TILE2)
	// 	SG = 2; SB = 1; SN = 64; SI = 64;
	// 	SM_SB = 64;SM_SN=64; SM_SM=64;
	// #endif
	
	
	// #if(TILE3)
	// 	SG = 1; SB = 64; SN = 1; SI = 128;
	// 	SM_SB = 1;SM_SN=64; SM_SM=64;
	// #endif
	
	// #if(TILE4)
	// 	SG = 4; SB = 64; SN = 32; SI = 1;
	// 	SM_SB = 1;SM_SN=64; SM_SM=64;
	// #endif
	
	
	
	float scale = 1e9/1e12;
	float TFLOP_MM  =scale* SG*SB*SN*SI;   
	float TFLOP_SM  =scale* SM_SB*SM_SN*SM_SM;   

	cout << "TFLOPS " << TFLOP_MM+TFLOP_SM << endl;
	cout << "TFLOPS(MULT)" << TFLOP_MM<<endl;
	
	// return 0;
		
	
	
	
	//Focus on embedding
	// #if(TILE1)
	// SH = 1;SN = 1;SB = 1;SM = 1;SE = 64;SD = 64;// SO = 64;
	// SNN = 64; SMM = 64; SDD = 128;
	// #endif
		
		
		
		
		
		
	//Simulation
	unsigned long long cycles = 0;
	unsigned long long actual_cycles = 0;
	unsigned long long xreuse = 0;
	unsigned long long wkreuse = 0;
	unsigned long long wqreuse = 0;
	unsigned long long kreuse = 0;
	unsigned long long qreuse = 0;
	
	int SMM;
	// int SNN;
	int SDD;
	int SBB;
	int Wkcache;
	//In sequence
	//K generation
	int SNN;
	
	
	
	
	#if(DECODE)
		cout << "DECODING"<<endl;
	
		
		SMM = MM_SBB;
		SDD = MM_SNN;
		Wkcache =Wcache; 
		for(int mmm = 0; mmm < DimN; mmm += SMM){
		for(int ddd = 0; ddd < DimD; ddd += SDD){

			#if(OS)        //[B,H,M]                             
				for(int b = 0; b < DimB; b += SG ){
				for(int h = 0; h < DimH; h +=   1  ){	
				for(int m = 0; m+mmm < std::min(DimN,mmm+SMM) ; m +=   SB ){
					
				for(int d = 0; d+ddd < std::min(DimD,ddd+SDD) ; d +=   SN ){
				for(int e = 0; e < DimE; e +=    SI ){
						int X_reuse = (DimE <= Xcache & d > 0) | (DimE*SMM <= Xcache & h > 0) |
							(DimB*DimE*SMM <= Xcache & ddd > 0) ;				
						int Wk_reuse = (DimE*SDD <= Wkcache & m > 0) | 
							(DimE*SDD*DimH <= Wkcache & b > 0) |(DimE*DimD*DimH <= Wkcache & mmm > 0) ;					
			#endif
			#if(WS)             // [H,D,E]
				for(int h = 0; h < DimH; h +=   1  ){
				for(int d = 0; d+ddd < std::min(DimD,ddd+SDD) ; d +=   SN ){
				for(int e = 0; e < DimE; e +=    SI ){
				
				for(int b = 0; b < DimB; b += SG ){
				for(int m = 0; m+mmm < std::min(DimN,mmm+SMM) ; m +=   SB ){
					int X_reuse = (DimE*SMM*DimB <= Xcache & d > 0) | (DimE*SMM*DimB <= Xcache & h > 0) |
						(DimB*DimE*SMM <= Xcache & ddd > 0) ;				
					int Wk_reuse = (1 <= Wkcache & m > 0) | 
						(1 <= Wkcache & b > 0) |(DimE*DimD*DimH <= Wkcache & mmm > 0) ;					
			#endif
			#if(XS)           // [B,M,E]           
				for(int e = 0; e < DimE; e +=    SI ){
					
					for(int b = 0; b < DimB; b += SG ){
					for(int m = 0; m+mmm < std::min(DimN,mmm+SMM) ; m +=   SB ){
				
				for(int h = 0; h < DimH; h +=   1  ){	
				for(int d = 0; d+ddd < std::min(DimD,ddd+SDD) ; d +=   SN ){
						int X_reuse = (1 <= Xcache & d > 0) | (1 <= Xcache & h > 0) |
							(DimB*DimE*SMM <= Xcache & ddd > 0) ;				
						int Wk_reuse = (DimH*SDD <= Wkcache & m > 0) | 
							(SDD*DimH <= Wkcache & b > 0) |(DimE*DimD*DimH <= Wkcache & mmm > 0) ;					
			#endif
			#if(KS)        //[B,H,M]
				for(int b = 0; b < DimB; b += SG ){
				for(int h = 0; h < DimH; h +=   1  ){	
				for(int m = 0; m+mmm < std::min(DimN,mmm+SMM) ; m +=   SB ){
					
				for(int d = 0; d+ddd < std::min(DimD,ddd+SDD) ; d +=   SN ){
				for(int e = 0; e < DimE; e +=    SI ){
						int X_reuse = (DimE <= Xcache & d > 0) | (DimE*SMM <= Xcache & h > 0) |
							(DimB*DimE*SMM <= Xcache & ddd > 0) ;				
						int Wk_reuse = (DimE*SDD <= Wkcache & m > 0) | 
							(DimE*SDD*DimH <= Wkcache & b > 0) |(DimE*DimD*DimH <= Wkcache & mmm > 0) ;					
			#endif
				cycles += MULT_cyc;
				
				
				
				int cycle_round = 0;
				int reuse_round = SRAM_read_cyc;
				int round = 0;
			
				if(xreuse){
				}else{
					cycle_round +=	DRAM_read_cyc;
				}
				if(wkreuse){
				}else{
					cycle_round +=	DRAM_read_cyc;
				}		
				round = max(reuse_round, cycle_round);;
				
				actual_cycles += round;
							
				
			}}}}}
		}}
	#else
		
			cout << "PREFILLING"<<endl;
		
		SMM = MM_SBB;
		SDD = MM_SNN;
		Wkcache =Wcache; 
		for(int mmm = 0; mmm < DimM; mmm += SMM){
		for(int ddd = 0; ddd < DimD; ddd += SDD){
		
			#if(OS)        //[B,H,M]                             
				for(int b = 0; b < DimB; b += SG ){
				for(int h = 0; h < DimH; h +=   1  ){	
				for(int m = 0; m+mmm < std::min(DimM,mmm+SMM) ; m +=   SB ){
					
				for(int d = 0; d+ddd < std::min(DimD,ddd+SDD) ; d +=   SN ){
				for(int e = 0; e < DimE; e +=    SI ){
						int X_reuse = (DimE <= Xcache & d > 0) | (DimE*SMM <= Xcache & h > 0) |
							(DimB*DimE*SMM <= Xcache & ddd > 0) ;				
						int Wk_reuse = (DimE*SDD <= Wkcache & m > 0) | 
							(DimE*SDD*DimH <= Wkcache & b > 0) |(DimE*DimD*DimH <= Wkcache & mmm > 0) ;					
			#endif
			#if(WS)             // [H,D,E]
				for(int h = 0; h < DimH; h +=   1  ){
				for(int d = 0; d+ddd < std::min(DimD,ddd+SDD) ; d +=   SN ){
				for(int e = 0; e < DimE; e +=    SI ){
				
				for(int b = 0; b < DimB; b += SG ){
				for(int m = 0; m+mmm < std::min(DimM,mmm+SMM) ; m +=   SB ){
					int X_reuse = (DimE*SMM*DimB <= Xcache & d > 0) | (DimE*SMM*DimB <= Xcache & h > 0) |
						(DimB*DimE*SMM <= Xcache & ddd > 0) ;				
					int Wk_reuse = (1 <= Wkcache & m > 0) | 
						(1 <= Wkcache & b > 0) |(DimE*DimD*DimH <= Wkcache & mmm > 0) ;					
			#endif
			#if(XS)           // [B,M,E]           
				for(int e = 0; e < DimE; e +=    SI ){
					
					for(int b = 0; b < DimB; b += SG ){
					for(int m = 0; m+mmm < std::min(DimM,mmm+SMM) ; m +=   SB ){
				
				for(int h = 0; h < DimH; h +=   1  ){	
				for(int d = 0; d+ddd < std::min(DimD,ddd+SDD) ; d +=   SN ){
						int X_reuse = (1 <= Xcache & d > 0) | (1 <= Xcache & h > 0) |
							(DimB*DimE*SMM <= Xcache & ddd > 0) ;				
						int Wk_reuse = (DimH*SDD <= Wkcache & m > 0) | 
							(SDD*DimH <= Wkcache & b > 0) |(DimE*DimD*DimH <= Wkcache & mmm > 0) ;					
			#endif
			#if(KS)        //[B,H,M]
				for(int b = 0; b < DimB; b += SG ){
				for(int h = 0; h < DimH; h +=   1  ){	
				for(int m = 0; m+mmm < std::min(DimM,mmm+SMM) ; m +=   SB ){
					
				for(int d = 0; d+ddd < std::min(DimD,ddd+SDD) ; d +=   SN ){
				for(int e = 0; e < DimE; e +=    SI ){
						int X_reuse = (DimE <= Xcache & d > 0) | (DimE*SMM <= Xcache & h > 0) |
							(DimB*DimE*SMM <= Xcache & ddd > 0) ;				
						int Wk_reuse = (DimE*SDD <= Wkcache & m > 0) | 
							(DimE*SDD*DimH <= Wkcache & b > 0) |(DimE*DimD*DimH <= Wkcache & mmm > 0) ;					
			#endif
				cycles += MULT_cyc;
				
				
				
				int cycle_round = 0;
				int reuse_round = SRAM_read_cyc;
				int round = 0;
			
				if(xreuse){
				}else{
					cycle_round +=	DRAM_read_cyc;
				}
				if(wkreuse){
				}else{
					cycle_round +=	DRAM_read_cyc;
				}		
				round = max(reuse_round, cycle_round);;
				
				actual_cycles += round;
							
				
			}}}}}
		}}
	
	
	#endif
	
	// cout << "extra " << ((DimB*DimM*DimD*DimH)/SG/1/SB/SN)*DRAM_read_cyc +((DimB*DimM*DimD*DimH)/SG/1/SB/SN)* DRAM_read_cyc<<endl;
	actual_cycles *= 3;
	actual_cycles += ((DimB*DimM*DimD*DimH)/SG/1/SB/SN)*DRAM_read_cyc*3 +((DimB*DimM*DimD*DimH)/SG/1/SB/SN)* DRAM_read_cyc;
	
	cout << "KQVGen " << actual_cycles/1e9  <<endl;
	
	
	//KQV generation
	// int macs = 0;
	// for(int mmm = 0; mmm < DimN; mmm += SMM){
	// for(int ddd = 0; ddd < DimD; ddd += SDD){

	// 	// #if(OS)                                     
	// 		for(int b = 0; b < DimB; b += SG ){
	// 		for(int h = 0; h < DimH; h +=   1  ){	
	// 		for(int m = 0; m+mmm < std::min(DimN,mmm+SNN) ; m +=   SB ){
	// 		for(int d = 0; d+ddd < std::min(DimD,ddd+SDD) ; d +=   SN ){
	// 		for(int e = 0; e < DimE; e +=    SI ){
	// 				int X_reuse = (DimE <= Xcache & d > 0) | (DimE*SMM <= Xcache & h > 0) |
	// 					(DimB*DimE*SMM <= Xcache & ddd > 0) ;				
	// 				int Wk_reuse = (DimE*SDD <= Wkcache & m > 0) | 
	// 					(DimE*SDD*DimH <= Wkcache & b > 0) |(DimE*DimD*DimH <= Wkcache & mmm > 0) ;					
	// 	// #endif
		
	// 		cycles += MULT_cyc;
			
	// 		macs += 1;
			
			
	// 		int cycle_round = 0;
	// 		int reuse_round = SRAM_read_cyc;
	// 		int round = 0;
		
	// 		if(xreuse){
	// 		}else{
	// 			cycle_round +=	DRAM_read_cyc;
	// 		}
	// 		if(wkreuse){
	// 		}else{
	// 			cycle_round +=	DRAM_read_cyc;
	// 		}		
	// 		round = max(reuse_round, cycle_round);;
			
	// 		actual_cycles += round;
						
			
	// 	}}}}}
	// }}
	// // actual_cycles += ((DimB*DimM*DimD*DimH)/SG/1/SB/SN)*DRAM_read_cyc +((DimB*DimM*DimD*DimH)/SG/1/SB/SN)* DRAM_read_cyc;
	
	// cout << "extra " << ((DimB*DimM*DimD*DimH)/SG/1/SB/SN)*SRAM_read_cyc +((DimB*DimM*DimD*DimH)/SG/1/SB/SN)* DRAM_read_cyc<<endl;
	// cout << "KQVGeneration " << 3*actual_cycles/1e9  <<endl;
	// actual_cycles = 0;
	
	
	
	
	//Score
	int Kcache;
	int Qcache;
	Kcache = Xcache;
	Qcache = Wcache;
	SNN = MM_SBB;
	SMM = MM_SNN;
	
	// cout << SNN <<endl;
	// cout << SMM <<endl;
	// cout << SDD << endl;
	
	// cout <<SB <<endl;
	// cout << SN <<endl;
	// cout << SI <<endl;
	// cout << SG <<endl;
	unsigned long long  idx = 0;
	
	// cout << DimM <<endl;
	// cout << DimN <<endl;
	// cout << DimD  <<endl;
	
	// return 0;/
	for(int mmm = 0; mmm < DimM; mmm += SMM){
	for(int nnn = 0; nnn < DimN; nnn += SNN){
	for(int ddd = 0; ddd < DimD; ddd += SDD){	
	
	#if(OS | KS)  
	for(int b = 0; b < DimB; b += SG){
		for(int h = 0; h < DimH; h += 1){
		for(int n = 0; n+nnn < nnn+SNN; n += SB){	
		for(int m = 0; m+mmm < mmm+SMM; m += SN){
		for(int d = 0; d+ddd < ddd+SDD; d += SI){
				int K_reuse = (SDD*SMM <= Kcache & n > 0) |
					(DimD*DimH*DimB*SMM <= Kcache & nnn > 0) 
					;
				
				int Q_reuse = (SDD <= Qcache & m > 0) |
					(DimD*DimH*DimB*SMM <= Qcache & mmm > 0) 
					;
		#endif
	#if(WS)//KCache, [B,M,H,D]
	for(int b = 0; b < DimB; b += SG){
		for(int h = 0; h < DimH; h += 1){
		for(int m = 0; m+mmm < mmm+SMM; m += SN){
		for(int d = 0; d+ddd < ddd+SDD; d += SI){
			for(int n = 0; n+nnn < nnn+SNN; n += SB){	
				int K_reuse = (1 <= Kcache & n > 0) |
					(DimH*DimM*DimD*DimB <= Kcache & nnn > 0) 
					;
				
				int Q_reuse = (SDD*SNN <= Qcache & m > 0) |
					(DimD*DimH*DimB*SNN <= Qcache & mmm > 0) 
					;
		#endif
	#if(XS)//QCache [B,N,H,D]
	for(int b = 0; b < DimB; b += SG){
		for(int h = 0; h < DimH; h += 1){
		for(int n = 0; n+nnn < nnn+SNN; n += SB){	
		for(int d = 0; d+ddd < ddd+SDD; d += SI){
	
	for(int m = 0; m+mmm < mmm+SMM; m += SN){
				int K_reuse = (SDD*SMM <= Kcache & n > 0) |
					(DimD*DimH*DimB*SMM <= Kcache & nnn > 0) 
					;
				
				int Q_reuse = (1 <= Qcache & m > 0) |
					(DimD*DimH*DimB*SMM <= Qcache & mmm > 0) 
					;
		#endif
		
		
						#if(DECODE)
							int KCache_hit = !(SMM+mmm >= DimM);  
							if(KCache_hit){
								//If cache hit, fetch K_reuse == 1
								K_reuse = 1;
							}
						#endif
						
			
			
						int cycle_round = 0;
						int reuse_round = SRAM_read_cyc;
						int round = 0;
						
						if(K_reuse & Q_reuse){
							round = max(reuse_round, cycle_round);;		
						}else if(K_reuse){		
							cycle_round +=	DRAM_read_cyc;
							round = max(reuse_round, cycle_round);;
						}else if(Q_reuse){
							cycle_round +=	DRAM_read_cyc;	
							round = max(reuse_round, cycle_round);;
						}else{
							cycle_round +=	DRAM_read_cyc;
							cycle_round +=	DRAM_read_cyc;
							round = max(reuse_round, cycle_round);;
						}
						actual_cycles += round;
	
		}}}}}
	}}}
	// cout << "macs"<<idx<<endl;
	actual_cycles += ((DimB*DimM*DimN*DimH)/SG/1/SB/SN)* DRAM_read_cyc;
	// cout << "extra " << ((DimB*DimM*DimD*DimH)/SG/1/SB/SN)*SRAM_read_cyc +((DimB*DimM*DimD*DimH)/SG/1/SB/SN)* DRAM_read_cyc<<endl;	
	cout << "Score " << actual_cycles/1e9  <<endl;
	
	
	//softmax
	
	for(int mmm = 0; mmm < DimM; mmm += SM_SMM){
	for(int nnn = 0; nnn < DimN; nnn += SM_SNN){
	
	for(int b = 0; b < DimB; b += SM_SB){
		for(int h = 0; h < DimH; h += 1){
		for(int n = 0; n+nnn < nnn+SNN; n += SM_SM){	
		for(int m = 0; m+mmm < mmm+SMM; m += SM_SN){
			
						int cycle_round = 0;
						int reuse_round = SRAM_read_cyc;
						int round = DRAM_read_cyc;
						
						actual_cycles += 2*round;
	
		}}}}
	}}
	
	// cout << "extra " << ((DimB*DimM*DimD*DimH)/SG/1/SB/SN)*DRAM_read_cyc +((DimB*DimM*DimD*DimH)/SG/1/SB/SN)* DRAM_read_cyc<<endl;
	// actual_cycles += ((DimB*DimM*DimD*DimH)/SG/1/SB/SN)*DRAM_read_cyc +((DimB*DimM*DimD*DimH)/SG/1/SB/SN)* DRAM_read_cyc;
	cout << "Softmax " << actual_cycles/1e9  <<endl;	
			
	//Output Calculation
	int TiledN = MM_SBB;
	int TiledD = MM_SNN;
	int Pcache = Xcache;//[B,N,M,H]  , D
	int Vcache = Wcache; //[B,M,H,D] , N
	for(int mmm = 0; mmm < DimM; mmm += DimM){
	for(int nnn = 0; nnn < DimN; nnn += MM_SBB){
	for(int ddd = 0; ddd < DimD; ddd += MM_SNN){
	
		#if(OS | KS)		
		for(int b = 0; b < DimB; b += SG){
		for(int h = 0; h < DimH; h += 1){
		for(int n = 0; n+nnn < nnn+MM_SBB; n += SB){	
		for(int m = 0; m+mmm < mmm+DimM; m += SI){
		for(int d = 0; d+ddd < std::min(DimD,ddd+MM_SNN) ; d +=   SN ){
					int P_reuse = (1 <= Pcache & d > 0) | 
						(DimB*TiledN*DimH*DimM <= Pcache & ddd > 0) ;				
					int V_reuse = (DimM*TiledD <= Vcache & n > 0) | 
						(DimB*DimM*DimH*TiledD <= Wkcache & nnn > 0) ;		
		#endif
		#if(WS) //[B,M,h,D]
		for(int b = 0; b < DimB; b += SG){
		for(int h = 0; h < DimH; h += 1){	
		for(int m = 0; m+mmm < mmm+DimM; m += SI){
		for(int d = 0; d+ddd < std::min(DimD,ddd+MM_SNN) ; d +=   SN ){
			
			for(int n = 0; n+nnn < nnn+MM_SBB; n += SB){
				
					int P_reuse = (TiledN <= Pcache & d > 0) | 
						(DimB*TiledN*DimH*DimM <= Pcache & ddd > 0) ;				
					int V_reuse = (1 <= Vcache & n > 0) | 
						(DimB*DimM*DimH*TiledD <= Wkcache & nnn > 0) ;		
		#endif
		#if(XS) //[B,N,M,H]
		for(int b = 0; b < DimB; b += SG){
		for(int h = 0; h < DimH; h += 1){
		for(int n = 0; n+nnn < nnn+MM_SBB; n += SB){	
		for(int m = 0; m+mmm < mmm+DimM; m += SI){
			
		for(int d = 0; d+ddd < std::min(DimD,ddd+MM_SNN) ; d +=   SN ){
					int P_reuse = (1 <= Pcache & d > 0) | 
						(DimB*TiledN*DimH*DimM <= Pcache & ddd > 0) ;				
					int V_reuse = (DimM*TiledD <= Vcache & n > 0) | 
						(DimB*DimM*DimH*TiledD <= Wkcache & nnn > 0) ;		
		#endif
		
		
										#if(DECODE)
											int VCache_hit = !(SMM+mmm >= DimM);  
											if(VCache_hit){
												//If cache hit, fetch K_reuse == 1
												V_reuse = 1;
											}
										#endif
									
				int cycle_round = 0;
				int reuse_round = SRAM_read_cyc;
				int round = 0;//DRAM_read_cyc;
				if(P_reuse){
				}else{
					cycle_round +=	DRAM_read_cyc;
				}
				if(V_reuse){
				}else{
					cycle_round +=	DRAM_read_cyc;
				}		
				round = max(reuse_round, cycle_round);;				
				actual_cycles += round;

		}}}}}
	}}}
	
	// cout << "extra " << ((DimB*DimM*DimD*DimH)/SG/1/SB/SN)*DRAM_read_cyc +((DimB*DimM*DimD*DimH)/SG/1/SB/SN)* DRAM_read_cyc<<endl;
	actual_cycles += ((DimB*DimN*DimD*DimH)/SG/1/SB/SN)* DRAM_read_cyc;
	cout << "Out " << actual_cycles/1e9  <<endl;		

	return 0;
}

SimResult prefill_mha_fused(

	int H,  int HH,	int SH,	 int SSH,  				//	int SHH = 1;
	int N,  int NN, int SN,	 int SSN,  int SNN,
	int B,  int BB,	int SB,  int SSB,  					//int SBB = 1;
	int M,  int MM, int SM,  int SSM,  int SMM,
	int D,  int DD, int SD,  int SSD,  int SDD,
	int O,  int OO, int SO,  int SSO 				,int SOO 	,
	
	
	float PhiRowXTopKRatio ,
	float PhiColWTopKRatio ,
	float PhiColXThresVal,
	float PhiColWThresVal ,
	float PhiSpargAttenTopKRatio,
	float PhiSpargAttenThresVal ,
			
	//Sparse Set
	int PhiX ,
	int PhiW ,
	
	int PhiRowXTopK ,
	int PhiColWTopK ,
	int PhiRowXThres,
	int PhiColWThres,
	
	
	int PhiSpargAttenTopK ,
	int PhiSpargAttenThres,
	
	int PhiXMem,
	int PhiWMem,
	
	int WindowAttenComp ,
	int WindowAttenMem 
	
	
	

){
	cout << "prefill_mha_fused" << endl;
	//A transformer / QWen1 layer (prefill)
	int dModel = 32;
	int numHeads = 2;
	int Batch = 1;
	int Seq = 2;
	
	
	dModel = DMODEL; //1024
	numHeads = HEADS; //16
	Batch = BATCH;//4
	Seq = SEQ;//SEQ=1024
	
	//L1 - 16x8 = 128kb
	int cache = CACHE;
	
	//MM
	int Kcache  = cache;
	int Vcache  = cache;
	int Qcache  = cache;
	int PScache = cache; 	   
	int Xcache  = cache;                           
	int Wkcache = cache;                            
	int Wvcache = cache;                           
	int Wqcache = cache;
		
	
	//Softmax
	int Scache = cache;
	
	//DRAM
	int DRAM_read_cyc = 4;
	int SRAM_read_cyc = 1;
	int MULT_cyc = 1;
		
	int DimB = Batch   ;
	int DimN = Seq     ;
	int DimH = numHeads    ;
	int DimM = Seq     ;
	int DimD = dModel  ;
	int DimE = dModel  ;
	
	
				#if(DECODE)
	DimB = Batch   ;
	DimN = 1     ;
	DimH = numHeads    ;
	DimM = Seq     ;
	DimD = dModel  ;
	DimE = dModel  ;
				#endif
						
						
		
	///////////////////////////////////////
	//Reconfigurable Array
	//matrix multiply 
	// int SH = 1;
	// int SN = 1;
	// int SB = 1;
	// int SM = 1;
	// int SD = 1;
	// int SO = 1;
	
	// int SNN = 2;
	// int SMM = 2;
	// int SOO = 2;
	// int SDD = 2;
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	
	// int H = 1;	int HH = 1;	int SH = 1;	 int SSH = 1;  					int SHH = 1;
	// int N = 1;	int NN = 1; int SN = 1;	 int SSN = 4;  int SNN = 512;
	// int B = 1;  int BB = 1;	int SB = 1;  int SSB = 1;  					int SBB = 1;
	// int M = 1;  int MM = 1; int SM = 1;  int SSM = 4;  int SMM = 512;
	// int D = 1;  int DD = 1; int SD = 1;  int SSD = 1;  int SDD = 512;
	// int O = 1;  int OO = 1; int SO = 2;  int SSO = 1; 					
	
	// int SOO = 1;
	int SBB = 1;
	int SHH = 1;
	
	// float PhiRowXTopKRatio ;
	// float PhiColWTopKRatio ;
	// float PhiColXThresVal;
	// float PhiColWThresVal ;
	// float PhiSpargAttenTopKRatio;
	// float PhiSpargAttenThresVal ;
			
	// //Sparse Set
	// int PhiX = 0;
	// int PhiW = 0;
	
	// int PhiRowXTopK = 0;
	// int PhiColWTopK = 0;
	// int PhiRowXThres = 0;
	// int PhiColWThres = 0;
	
	
	// int PhiSpargAttenTopK = 0;
	// int PhiSpargAttenThres = 0;
	
	// int PhiXMem = 0;
	// int PhiWMem = 0;
	
	// int WindowAttenComp = 0;
	// int WindowAttenMem = 0;
	
	
	///////////////////////////////////////////////////////////////////////////////////////////////
	
	
	////////////////////////////////////////////////////////////////////////////
		// H = 1;	HH = 2;	SH = 4;	 SSH = 8;  					
		// N = 1;	NN = 2; SN = 4;	 SSN = 8;   SNN = 512;
		// B = 1;  BB = 2; SB = 4;  SSB = 8;  					
		// M = 1;  MM = 2; SM = 4;  SSM = 8;   SMM = 512;
		// D = 1;  DD = 2; SD = 4;  SSD = 8;   SDD = 512;
		// O = 1;  OO = 2; SO = 4;  SSO = 8; 					

		// H = 1;	HH = H*1;	SH = HH*1;	 SSH = SH*1;  					
		// N = 1;	NN = N*1;   SN = NN*1;	 SSN = SN*4;   SNN = 512;
		// B = 1;  BB = B*1;   SB = BB*1;   SSB = SB*1;  					
		// M = 1;  MM = M*1;   SM = MM*4;   SSM = SM*4;   SMM = 512;
		// D = 1;  DD = D*1;   SD = DD*1;   SSD = SD*1;   SDD = 512;
		// O = 1;  OO = O*1;   SO = OO*1;   SSO = SO*1; 					
		
		// float thres = 0.4;
		// float ratio = 0.5;
		
		// PhiX = 1;
		// PhiW = 1;
		// PhiRowXTopK = 1; PhiRowXTopKRatio = ratio;
		// PhiColWTopK = 1; PhiColWTopKRatio = ratio;
		// PhiRowXThres = 1; PhiColXThresVal = 0.4;
		// PhiColWThres = 1; PhiColWThresVal = 0.48;
		
		// PhiSpargAttenTopK = 1; PhiSpargAttenTopKRatio = ratio;
		// PhiSpargAttenThres = 1; PhiSpargAttenThresVal = thres;
		// PhiXMem = 1;
		// PhiWMem = 1;
		// WindowAttenComp = 1;
		// WindowAttenMem = 1;
				
		float Xsp = 0.5;
		float Wsp = 0.5;
		// float Psp = 0.0;
		// float KVsp = 0.1;
		// float Qsp = 0.1;

		float KVsp = 0.1; //basically dense
		float Qsp = 0.1; //basically dense
		float Psp = 0.2; //Can be very sparse due to softmax
	
	// 	Wsp = 0.5;
	// 	Xsp = 0.1;
		
	// 	PhiX = 1;
	// 	PhiW = 1;
		
		
		// PhiX = 0;
		// PhiW = 0;
		
		
		//0- balanced, 1 - average, 2 - worst 
		int sparsetype = 0;
		////////////////////////////////////////////////////////////////////////////////
		//
		
		
		/////////////////////////////////////////////////////////////////////////////
		//Super simple model
		// H = 1;	HH = H*1;	SH = HH*1;	 SSH = SH*1;  					
		// N = 1;  NN = N*1;   SN = NN*1;	 SSN = SN*4;   SNN = 512;
		// B = 1;  BB = B*1;   SB = BB*1;   SSB = SB*1;  					
		// M = 1;  MM = M*1;   SM = MM*4;   SSM = SM*4;   SMM = 512;
		// D = 1;  DD = D*1;   SD = DD*1;   SSD = SD*1;   SDD = 512;
		// O = 1;  OO = O*1;   SO = OO*1;   SSO = SO*1; 					
		
		//X
		int SKIP_W = PhiW;
		int SKIP_X = PhiX;
		int copy; int group; int multicast; int ins; int outs;
		int wcopy; int wgroup; int wmulticast; int wins; int wouts;
		int TN; int TNN; int TB; int TBB; int TII; int TI; int TSN; int TSB; int TSI;
		TN = H*(D+O); TNN = HH*(DD+OO); TSN = SH*(SD+SO);
		TB = B*M; TBB = BB*MM; TSB = SB*SM;
		TI = N; TII = NN; TSI = SN;
        if(SKIP_W && SKIP_X){
            copy = 1;
            group = TNN*TBB/TN/TB;
            multicast = 1;
            ins = TSN*TSI*TSB/group;
            outs = TNN*TII*TBB    /group  ;

            wcopy = 1;
            wgroup = TNN*TBB/TN/TB;
            wmulticast = 1;
            wins = TSN*TSI*TSB/group;
            wouts = TNN*TII*TBB    /group  ;
		}
        else if(SKIP_W){
            copy = TNN/TN;
            group = TBB/TB;
            multicast = 1;
            ins = TBB*TSI/group;
            outs =  TBB*TII/group;
            
            wcopy = 1;
            wgroup = TNN/TN;
            wmulticast = BB;
            wins = TSN*TSI/group;
            wouts =  TNN*TII/group  ;
		}
        else if(SKIP_X){
            copy = 1;
            group = TBB/TB;
            multicast = TNN;
            ins = TSB*TSI/group;
            outs =  TBB*TII/group  ;

            wcopy = TBB;
            wgroup = TNN/TN;
            wmulticast = 1;
            wins = TNN*TSI/group;
            wouts =  TNN*TII/group	;	
		}else{
			copy = 1;
			group = 1;
			multicast = 1;
			ins = 1;
			outs = 1;
		}
		
		
		
		float KVQGen_dense_cycles  = (float) SH/  (float)HH * SN/NN * (SD+SO)/(DD+OO) * SB/BB;
		float KVQGen_sparse_cycles_ideal = KVQGen_dense_cycles*(1-Wsp)*(1-Xsp);//, 1/KVQGen_dense_cycles ); 
		
		float data_amount = (float)SH*SN*(SD+SO)*SB*(1-Wsp)*(1-Xsp);
		
		cout << "dense\t" << ins/outs << endl;
		cout << "best\t" << int((data_amount/copy/group/1.0) /outs) << endl;
		cout << "avg\t" << int(min(1.0*ins/outs, min((data_amount/copy/group)*group /outs*1.0, (data_amount/copy/group)*1.5 /outs))) << endl;
		cout << "worst\t" << int(min(1.0*ins/outs, (data_amount/copy/group*group*1.0) /outs)) << endl;
		
		// cout << data_amount/copy/group/1.5 /ins << endl;
		// cout << data_amount/copy/group << endl;
		// cout << ins << endl;
		// cout << outs << endl;
		//float ins/outs;
		
		float in_data = SH*HH*SN*(SD+SO)*SB*(1-Wsp)*(1-Xsp);
		float w_in_terms = SH*HH*SN*(SD+SO)*SB*(1-Wsp)*(1-Xsp);
		
		float KVQGen_sparse_cycles_avg = int((data_amount/copy/group/1.0) /outs);//, 1/KVQGen_dense_cycles ); 
		float KVQGen_sparse_cycles_worst = int(min(1.0*ins/outs, (data_amount/copy/group*group*1.0) /outs)) ;//, 1/KVQGen_dense_cycles );
		
		// float wKVQGen_sparse_cycles_avg = int((data_amount/wcopy/wgroup/1.0) /wouts);//, 1/KVQGen_dense_cycles ); 
		// float wKVQGen_sparse_cycles_worst = int(min(1.0*ins/outs, (data_amount/wcopy/wgroup*group*1.0) /wouts)) ;//, 1/KVQGen_dense_cycles );
		
				
		// //Average ideal + average + worst
		float KVQGen_sparse_cycles = ceil(min(KVQGen_dense_cycles*1.0,
		(KVQGen_sparse_cycles_ideal + KVQGen_sparse_cycles_avg+KVQGen_sparse_cycles_worst)/3.0));
		
			// + wKVQGen_sparse_cycles_avg + wKVQGen_sparse_cycles_worst
		// cout << "copy="<<copy<<"\tgroup="<<group<<"\tmulticast="<<multicast<<"\tins="<<ins<<"\touts="<<outs<<endl;
		// cout << "wcopy="<<wcopy<<"\twgroup="<<wgroup<<"\twmulticast="<<wmulticast<<"\twins="<<wins<<"\twouts="<<wouts<<endl;
		
		
		cout << "KVQGen_dense_cycles\t" << KVQGen_dense_cycles << endl;
		
		cout << "KVQGen_sparse_cycles\t" << KVQGen_sparse_cycles << endl;
		
		
		

		TN = M; TNN = MM; TSN = SM;
		TB = N; TBB = NN; TSB = SN;
		TI = D; TII = DD; TSI = SD;
		if(SKIP_W && SKIP_X){
		    copy = 1;
		    group = TNN*TBB/TN/TB;
		    multicast = 1;
		    ins = TSN*TSI*TSB/group;
		    outs = TNN*TII*TBB    /group  ;
		
		    wcopy = 1;
		    wgroup = TNN*TBB/TN/TB;
		    wmulticast = 1;
		    wins = TSN*TSI*TSB/group;
		    wouts = TNN*TII*TBB    /group  ;
		}
		else if(SKIP_W){
		    copy = TNN/TN;
		    group = TBB/TB;
		    multicast = 1;
		    ins = TBB*TSI/group;
		    outs =  TBB*TII/group;
		    
		    wcopy = 1;
		    wgroup = TNN/TN;
		    wmulticast = BB;
		    wins = TSN*TSI/group;
		    wouts =  TNN*TII/group  ;
		}
		else if(SKIP_X){
		    copy = 1;
		    group = TBB/TB;
		    multicast = TNN;
		    ins = TSB*TSI/group;
		    outs =  TBB*TII/group  ;
		
		    wcopy = TBB;
		    wgroup = TNN/TN;
		    wmulticast = 1;
		    wins = TNN*TSI/group;
		    wouts =  TNN*TII/group	;	
		}
		
		float fused_dense_cycles  = (float) SN/  (float)NN * SM/MM * SD/DD;
		float fused_sparse_cycles_ideal = fused_dense_cycles*(1-KVsp)*(1-Qsp);//, 1/KVQGen_dense_cycles ); 
		
		data_amount = (float)SN*SM*SD*(1-KVsp)*(1-Qsp);
		
		cout << "dense\t" << ins/outs << endl;
		cout << "best\t" << int((data_amount/copy/group/1.0) /outs) << endl;
		cout << "avg\t" << int(min(1.0*ins/outs, min((data_amount/copy/group)*group /outs*1.0, (data_amount/copy/group)*1.5 /outs))) << endl;
		cout << "worst\t" << int(min(1.0*ins/outs, (data_amount/copy/group*group*1.0) /outs)) << endl;
		
		float fused_sparse_cycles_avg = int((data_amount/copy/group/1.0) /outs);//, 1/KVQGen_dense_cycles );
		float fused_sparse_cycles_worst = int(min(1.0*ins/outs, (data_amount/copy/group*group*1.0) /outs)) ;//, 1/KVQGen_dense_cycles );
	
		// float wfused_sparse_cycles_avg = int((data_amount/wcopy/wgroup/1.0) /wouts);//, 1/KVQGen_dense_cycles );
		// float wfused_sparse_cycles_worst = int(min(1.0*wins/wouts, (data_amount/wcopy*1.0) /wouts)) ;//, 1/KVQGen_dense_cycles );
			
		
			// + wfused_sparse_cycles_avg +  wfused_sparse_cycles_worst
		float fused_sparse_cycles = ceil(min(fused_dense_cycles*1.0,
			(fused_sparse_cycles_ideal + fused_sparse_cycles_avg+fused_sparse_cycles_worst)/3.0));
		cout << "Fused_dense_cycles\t" << fused_dense_cycles << endl;
		cout << "Fused_sparse_cycles\t" << fused_sparse_cycles << endl;
		
		float X_ratio = 1.0;
		if(PhiXMem){
			X_ratio = 1.0-Xsp;
		}
		float W_ratio = 1.0;
		if(PhiWMem){
			W_ratio = 1.0-Wsp;
		}
		float K_ratio = 1.0;
		if(PhiWMem){
			K_ratio = 1.0-KVsp;
		}
		float V_ratio = 1.0;
		if(PhiWMem){
			V_ratio = 1.0-Psp;
		}
		float Q_ratio = 1.0;
		if(PhiXMem){
			Q_ratio = 1.0-Qsp;
		}
		
				
		// float fused_dense_cycles  = SH/HH * SN/NN * SB/BB * SM/MM * SD/DD * SO/OO;// (SD+SO)/(DD+OO) * SB/BB;
		// float fused_sparse_cycles = 1; 
		
		
		
		// cout << "fused_dense_cycles\t" << fused_dense_cycles << endl;
		
		// cout << "fused_sparse_cycles\t" << fused_sparse_cycles << endl;
		
		//////////////////////////////////////////////////////////////////////////////////////////////////
	
	// #if(TILE1)
	// SH = 16;SN = 64;SB = 4;SM = 1;SO = 1;SD = 1;// SO = 64;
	// SNN = 128; SMM = 128; SDD = 128; SOO = 128;
	// #endif
	
	// #if(TILE2)
	// SH = 1;SN = 64;SB = 1;SM = 1;SO = 64;SD = 64;// SO = 64;
	// SNN = 128; SMM = 128; SDD = 128; SOO = 128;
	// #endif	

	// SNN = 128; SMM = 128; SDD = 128; SOO = 128;
	// #if(TILE3)
	// SH = 1;SN = 8;SB = 1;SM = 8;SO = 64;SD = 64;// SO = 64;
	// SNN = 64; SMM = 128; SDD = 128; SOO = 128;
	// #endif	

	// #if(TILE5)
	// SH = 8;SN = 4;SB = 4;SM = 4;SO = 8;SD = 8;// SO = 64;
	// SNN = 64; SMM = 128; SDD = 128; SOO = 128;
	
	// SH = 4;SN = 8;SB = 1;SM = 8;SO = 16;SD = 16;// SO = 64;
	// SNN = 64; SMM = 128; SDD = 128; SOO = 128;
	
	// #endif	
	
	// #if(TILE4)
	// SH = 8;SN = 1;SB = 4;SM = 16;SO = 1;SD = 16;// SO = 64;
	// SNN = 64; SMM = 64; SDD = 64; SOO = 64;
	// #endif	


	////DONT TOUCH
		int GSSD = SSD + SSO;
		int GSD = SD + SO;
		// int SI = SE;
		int GDD = DD + OO;
		int GD = D + O;
		
		int SSE = SSM;
		int SE = SM;
		int EE = MM;
		int E  = M;
	////DONT TOUCH								
								
						
								
	// 	// int TILING = 512;
	// 	SNN = TILING; SMM = TILING; SDD = TILING; SOO = TILING;
		
	//matrix multiply
	int MM_SG = 1; 
	int MM_SB = 1;
	int MM_SN = 64;
	int MM_SI = 64;
	
	int MM_SBB = 512;
	int MM_SGG = 512;
	int MM_SNN = 512;
	
	//softmax
	int SM_SB = SB;
	int SM_SN = SN;
	int SM_SM = SM;
	
	int SM_SNN = 64;
	int SM_SMM = 64;
	////////////////////////////////////////
	
	
	float scale = 1e9/1e12;
	float TFLOP_MM1  =scale* SM*SB*SN*SD*SH;   
	float TFLOP_SM   =scale* SM_SB*SM_SN*SM_SM;   
	float TFLOP_MM2  =scale* SM*SB*SN*SO*SH;   
	
	float TFLOP_MEGAM =scale* (SM*SB*SN*SH)*(SD+SO);

	cout << "TFLOPS " << TFLOP_MM1+TFLOP_SM+TFLOP_MM2 << endl;	
	cout << "TFLOPS(MULT)" << TFLOP_MEGAM<<endl;
	// return 0;
		
	//Simulation
	unsigned long long cycles = 0;
    float actual_cycles = 0;
	unsigned long long xreuse = 0;
	unsigned long long wkreuse = 0;
	unsigned long long wqreuse = 0;
	unsigned long long kreuse = 0;
	unsigned long long qreuse = 0;
	
	//In sequence
	//K generation
	
	// SMM = MM_SBB;
	// SDD = MM_SNN;
	// Wkcache =Wcache; 
	
	#if(DECODE)
	
		for(int mmm = 0; mmm < DimN; mmm += SMM){
		for(int ddd = 0; ddd < DimD; ddd += SDD){

			#if(OS | KS)        //[B,H,M]                             
				for(int b = 0; b < DimB; b += SB ){
				for(int h = 0; h < DimH; h +=   SH  ){	
				for(int m = 0; m+mmm < std::min(DimN,mmm+SMM) ; m +=   SM ){
					
				for(int d = 0; d+ddd < std::min(DimD,ddd+SDD) ; d +=  ( SD+SO) ){
				for(int e = 0; e < DimE; e +=    SN ){
						int X_reuse = (DimE <= Xcache & d > 0) | (DimE*SMM <= Xcache & h > 0) |
							(DimB*DimE*SMM <= Xcache & ddd > 0) ;				
						int Wk_reuse = (DimE*SDD <= Wkcache & m > 0) | 
							(DimE*SDD*DimH <= Wkcache & b > 0) |(DimE*DimD*DimH <= Wkcache & mmm > 0) ;					
			#endif
			#if(WS)             // [H,D,E]
				for(int h = 0; h < DimH; h +=   SH  ){
				for(int d = 0; d+ddd < std::min(DimD,ddd+SDD) ; d +=   ( SD+SO) ){
				for(int e = 0; e < DimE; e +=    SN ){
				
				for(int b = 0; b < DimB; b += SB ){
				for(int m = 0; m+mmm < std::min(DimN,mmm+SMM) ; m +=   SM ){
					int X_reuse = (DimE*SMM*DimB <= Xcache & d > 0) | (DimE*SMM*DimB <= Xcache & h > 0) |
						(DimB*DimE*SMM <= Xcache & ddd > 0) ;				
					int Wk_reuse = (1 <= Wkcache & m > 0) | 
						(1 <= Wkcache & b > 0) |(DimE*DimD*DimH <= Wkcache & mmm > 0) ;					
			#endif
			#if(XS)           // [B,M,E]           
				for(int e = 0; e < DimE; e +=    SN ){
					
						for(int b = 0; b < DimB; b += SB ){
					for(int m = 0; m+mmm < std::min(DimN,mmm+SMM) ; m +=   SM ){
				
				for(int h = 0; h < DimH; h +=   SH  ){	
				for(int d = 0; d+ddd < std::min(DimD,ddd+SDD) ; d +=   (SD+SO) ){
						int X_reuse = (1 <= Xcache & d > 0) | (1 <= Xcache & h > 0) |
							(DimB*DimE*SMM <= Xcache & ddd > 0) ;				
						int Wk_reuse = (DimH*SDD <= Wkcache & m > 0) | 
							(SDD*DimH <= Wkcache & b > 0) |(DimE*DimD*DimH <= Wkcache & mmm > 0) ;					
			#endif
			
			
				
				for(int bb = 0; bb < SB; bb += BB ){
				for(int hh = 0; hh < SH; hh +=   HH  ){	
				for(int mm = 0; mm < SM ; m +=   MM ){
				for(int dd = 0; dd < SD ; d +=  (DD+OO) ){
				for(int ee = 0; ee < SE ; e +=   EE ){
			
					cycles += MULT_cyc;
					
					
					
					int cycle_round = 0;
					int reuse_round = SRAM_read_cyc;
					int round = 0;
				
					if(X_reuse){
					}else{
						cycle_round +=	DRAM_read_cyc;
					}
					if(Wk_reuse){
					}else{
						cycle_round +=	DRAM_read_cyc;
					}		
					round = max(reuse_round, cycle_round);;
					
					actual_cycles += round;
				}}}}}
				
			}}}}}
		}}
	#else
	
		for(int mmm = 0; mmm < DimM; mmm += SMM){
		for(int ddd = 0; ddd < DimD; ddd += SDD){
		
			#if(OS | KS)        //[B,H,M]                             
				for(int b = 0; b < DimB; b += SB ){
				for(int h = 0; h < DimH; h +=   SH  ){	
				for(int m = 0; m+mmm < std::min(DimM,mmm+SMM) ; m +=   SM ){
					
				for(int d = 0; d+ddd < std::min(DimD,ddd+SDD) ; d +=  ( SD+SO) ){
				for(int e = 0; e < DimE; e +=    SN ){
						int X_reuse = (DimE <= Xcache & d > 0) | (DimE*SMM <= Xcache & h > 0) |
							(DimB*DimE*SMM <= Xcache & ddd > 0) ;				
						int Wk_reuse = (DimE*SDD <= Wkcache & m > 0) | 
							(DimE*SDD*DimH <= Wkcache & b > 0) |(DimE*DimD*DimH <= Wkcache & mmm > 0) ;					
			#endif
			#if(WS)             // [H,D,E]
				for(int h = 0; h < DimH; h +=   SH  ){
				for(int d = 0; d+ddd < std::min(DimD,ddd+SDD) ; d +=   ( SD+SO) ){
				for(int e = 0; e < DimE; e +=    SN ){
				
				for(int b = 0; b < DimB; b += SB ){
				for(int m = 0; m+mmm < std::min(DimM,mmm+SMM) ; m +=   SM ){
					int X_reuse = (DimE*SMM*DimB <= Xcache & d > 0) | (DimE*SMM*DimB <= Xcache & h > 0) |
						(DimB*DimE*SMM <= Xcache & ddd > 0) ;				
					int Wk_reuse = (1 <= Wkcache & m > 0) | 
						(1 <= Wkcache & b > 0) |(DimE*DimD*DimH <= Wkcache & mmm > 0) ;					
			#endif
			#if(XS)           // [B,M,E]           
				for(int e = 0; e < DimE; e +=    SN ){
					
						for(int b = 0; b < DimB; b += SB ){
					for(int m = 0; m+mmm < std::min(DimM,mmm+SMM) ; m +=   SM ){
				
				for(int h = 0; h < DimH; h +=   SH  ){	
				for(int d = 0; d+ddd < std::min(DimD,ddd+SDD) ; d +=   (SD+SO) ){
						int X_reuse = (1 <= Xcache & d > 0) | (1 <= Xcache & h > 0) |
							(DimB*DimE*SMM <= Xcache & ddd > 0) ;				
						int Wk_reuse = (DimH*SDD <= Wkcache & m > 0) | 
							(SDD*DimH <= Wkcache & b > 0) |(DimE*DimD*DimH <= Wkcache & mmm > 0) ;					
			#endif
			
					int mem_cycles = 0;
					int inner_cyc = 0;
					
					cycles += MULT_cyc;
					inner_cyc++;
					
					
					float cycle_round = 0;
					float reuse_round = SRAM_read_cyc;
					int round = 0;
											
					if(X_reuse){
					}else{
						cycle_round +=	DRAM_read_cyc*X_ratio;
					}
					if(Wk_reuse){
					}else{
						cycle_round +=	DRAM_read_cyc*W_ratio;
					}		
					round = max(reuse_round, cycle_round);
					
					// if(round < DRAM_read_cyc){
					// 	cout << "round\t" << round << endl;
					// }
					// actual_cycles += round;
					mem_cycles += round;
					// cout << "X_reuse " << ( X_reuse || Wk_reuse) << endl;
					
					
					//Grouping analysis
					
					int sparse_group = 1; 
					
					int group = SSB/SB * SSH/SH * SSM/SM * (SSD+SSO)/(SD+SO) * SSE/SE;
					
					// 	for(int bb = 0; bb < SB; bb += BB ){
					// 	for(int hh = 0; hh < SH; hh +=   HH  ){	
					// 	for(int mm = 0; mm < SM ; mm +=   MM ){
					// 	for(int dd = 0; dd < SD ; dd +=  (DD+OO) ){
					// 	for(int ee = 0; ee < SE ; ee +=   EE ){
									
									
					
					if(PhiSpargAttenTopK){
						sparse_group = PhiSpargAttenTopKRatio;
					}else{
						sparse_group = group;
					}
					
					// compute_cycles = 
					// mem_cycles = mem_cycles);
					// cout << KVQGen_sparse_cycles << "\t" << mem_cycles << endl;
					actual_cycles += max(KVQGen_sparse_cycles*1.0*sparse_group/group, 1.0*mem_cycles);
					
					
					// 	for(int bb = 0; bb < SB; bb += BB ){
					// 	for(int hh = 0; hh < SH; hh +=   HH  ){	
					// 	for(int mm = 0; mm < SM ; mm +=   MM ){
					// 	for(int dd = 0; dd < SD ; dd +=  (DD+OO) ){
					// 	for(int ee = 0; ee < SE ; ee +=   EE ){
									
									
									// PhiRowXTopK = 1; PhiRowXTopKRatio = ratio;
									// PhiColWTopK = 1; PhiColWTopKRatio = ratio;
									// PhiRowXThres = 1; PhiColXThresVal = 0.4;
									// PhiColWThres = 1; PhiColWThresVal = 0.48;
									
									// PhiSpargAttenTopK = 1; PhiSpargAttenTopKRatio = ratio;
									// PhiSpargAttenThres = 1; PhiSpargAttenThresVal = thres;
									// PhiXMem = 1;
									// PhiWMem = 1;
									// WindowAttenComp = 1;
									// WindowAttenMem = 1;
					// 		cycles += MULT_cyc;
					// 		inner_cyc++;
							
							
					// 		int cycle_round = 0;
					// 		int reuse_round = SRAM_read_cyc;
					// 		int round = 0;
						
					// 		if(X_reuse){
					// 		}else{
					// 			cycle_round +=	DRAM_read_cyc;
					// 		}
					// 		if(Wk_reuse){
					// 		}else{
					// 			cycle_round +=	DRAM_read_cyc;
					// 		}		
					// 		round = max(reuse_round, cycle_round);;
							
					// 		// if(round < DRAM_read_cyc){
					// 		// 	cout << "round\t" << round << endl;
					// 		// }
					// 		// actual_cycles += round;
					// 		mem_cycles += round;
					// 	}}}}}
						// // if()
						// cout << "X_reuse " << ( X_reuse || Wk_reuse) << endl;
						// // cout << KVQGen_sparse_cycles << "\t" << mem_cycles << endl;
						// actual_cycles += max(KVQGen_sparse_cycles*1.0, 1.0*mem_cycles);
						//return 0;
						// cout()
				
			}}}}}
		}}
	
	#endif
	
	// cout << "extra " << ((DimB*DimM*DimD*DimH)/SG/1/SB/SN)*DRAM_read_cyc +((DimB*DimM*DimD*DimH)/SG/1/SB/SN)* DRAM_read_cyc<<endl;
	actual_cycles *= 3;
	// actual_cycles += ((DimB*DimM*DimD*DimH)/SM/SH/SB/(SO+SD))*DRAM_read_cyc*3 +((DimB*DimM*DimD*DimH)/SM/SH/SB/(SO+SD))* DRAM_read_cyc;
	
	cout << "KQVGen " << actual_cycles/1e9  <<endl;
	
	
	
	//Score - Softmax - Output (FUSED)
	for(int nnn = 0; nnn < DimN; nnn += SNN){
	for(int mmm = 0; mmm < DimM; mmm += SMM){
	for(int ddd = 0; ddd < DimD; ddd += SDD){
	for(int ooo = 0; ooo < DimD; ooo += SOO){


	//K: [B,M,H,D] n o
	//V: [B,M,H,O] n d
	//Q: [B,N,H,D] m o
	#if(OS)                                 
		for(int b = 0; b < DimB; b += SB){
		for(int h = 0; h < DimH; h += SH){	
		for(int n = 0; n+nnn < std::min(DimN, nnn+SNN); n += SN){	
		for(int o = 0; o+ooo < std::min(DimD, ooo+SOO); o += SO){
		
		for(int m = 0; m+mmm < std::min(DimM,mmm+SMM); m += SM){
		for(int d = 0; d+ddd < std::min(DimD,ddd+SDD); d += SD){

				int K_reuse = (SDD*SMM <= Kcache & n > 0) |
					(DimD*DimH*DimB*SMM <= Kcache & nnn > 0) |
					
					(SDD*SMM <= Kcache & o > 0) |
					(DimD*DimH*DimB*SMM <= Kcache & ooo > 0) ;
				
				int V_reuse = (SDD*SMM <= Vcache & n > 0) |
					(SOO*DimH*DimB*SMM <= Vcache & nnn > 0) |
					
					(1 <= Vcache & d > 0) |
					(SOO*DimH*DimB*SMM <= Vcache & ddd > 0) ;
				
				int Q_reuse = (SDD <= Qcache & m > 0) |
					(SDD*DimH*DimB*SMM <= Qcache & mmm > 0) |
					
					(SDD*SMM <= Qcache & o > 0) |
					(SDD*DimH*DimB*SMM <= Qcache & ooo > 0) ;
					
				int P_reuse = (1 <= PScache & d > 0) |
					(DimH*DimB*SNN*SMM <= PScache & ddd > 0) |
					
					(SMM <= PScache & o > 0) |
					(DimH*DimB*SMM*SNN <= PScache & ooo > 0) ;				
	#endif


	//K: [B,M,H,D] n o
	//V: [B,M,H,O] n d
	//Q: [B,N,H,D] m o
	//P: [B,M,N,H] d o
	#if(WS | XS | KS)	
		//Key stationary 
		for(int b = 0; b < DimB; b += SB){
		for(int h = 0; h < DimH; h += SH){				
		for(int m = 0; m+mmm < std::min(DimM,mmm+SMM); m += SM){
		for(int d = 0; d+ddd < std::min(DimD,ddd+SDD); d += SD){
				
		for(int n = 0; n+nnn < std::min(DimN, nnn+SNN); n += SN){	
		for(int o = 0; o+ooo < std::min(DimD, ooo+SOO); o += SO){

		
			int K_reuse = (1 <= Kcache & n > 0) |
				(SDD*DimH*DimB*SMM <= Kcache & ooo > 0) |
				(1 <= Kcache & o > 0) |
				(DimD*DimH*DimB*DimM <= Kcache & nnn > 0) ;
			
			
			int V_reuse = (SOO <= Vcache & n > 0) |
				(SOO*DimH*DimB*SMM <= Vcache & nnn > 0) |
				(SOO <= Vcache & d > 0) |
				(SOO*DimH*DimB*SMM <= Vcache & ddd > 0) ;
			
			
			int Q_reuse = (SDD*SNN <= Qcache & m > 0) |
				(SDD*DimH*DimB*SNN <= Qcache & mmm > 0) |
				
				(1 <= Qcache & o > 0) |
				(SDD*DimH*DimB*SNN <= Qcache & ooo > 0) ;

			int P_reuse = (SNN <= PScache & d > 0) |
				(DimH*DimB*SNN*SMM <= PScache & ddd > 0) |
				
				(1 <= PScache & o > 0) |
				(DimH*DimB*SMM*SNN <= PScache & ooo > 0) ;

	#endif						
				
	#if(QS)	
		//Query stationary 
		for(int b = 0; b < DimB; b += SB){	
		for(int n = 0; n+nnn < std::min(DimN,nnn+SNN); n += SN){
		for(int h = 0; h < DimH; h += SH){
		for(int d = 0; d+ddd < std::min(DimD,ddd+SDD); d += SD){
		for(int m = 0; m+mmm < std::min(DimM,mmm+SMM); m += SM){
		for(int e = 0; e < DimE; e += SE){

	#endif
			//Value Sparsity Tiling

			// for(int bb = 0; bb < SB; bb += BB ){
			// for(int hh = 0; hh < SH; hh += HH ){				
			// for(int mm = 0; mm < SM ; mm +=   MM ){
			// for(int dd = 0; dd < SD ; dd +=   DD ){
			// for(int nn = 0; nn < SM ; nn +=   NN ){	
			// for(int oo = 0; oo < SO ; oo +=   OO ){

				if(WindowAttenMem){
					int T = 128;
					if(m+mmm >16 and (m +mmm < n+nnn-T or n+nnn+T < m+mmm)){
						continue;
					}
				}
						
				cycles += MULT_cyc;
				
				int mem_cycles;
					#if(DECODE)
						int KCache_hit = !(SMM+mmm >= DimM);  
						if(KCache_hit){
							//If cache hit, fetch K_reuse == 1
							K_reuse = 1;
						}
						int VCache_hit = !(SOO+ooo >= DimM);  
						if(VCache_hit){
							//If cache hit, fetch K_reuse == 1
							V_reuse = 1;
						}
					#endif
							
							
							
					float cycle_round = 0;
					float reuse_round = SRAM_read_cyc;
					int round = 0;
					
					if(P_reuse & V_reuse){
						if(d+SD>=DimD){
							if(m+SM>=DimM){
								round = max(reuse_round, cycle_round);;
							}
						}					
					}else if(P_reuse){	
						if(d+SD>=DimD){
						if(V_reuse){
						}else{
							cycle_round +=	DRAM_read_cyc*V_ratio;
						}
						
						round = max(reuse_round, cycle_round);;
						}
					}else if(V_reuse){
						if(K_reuse){
						}else{
							cycle_round +=	DRAM_read_cyc*K_ratio;
						}
						if(Q_reuse){
						}else{
							cycle_round +=	DRAM_read_cyc*Q_ratio;
						}	
						round = max(reuse_round, cycle_round);;
					}else{
						if(K_reuse){
						}else{
							cycle_round +=	DRAM_read_cyc*K_ratio;
						}
						if(Q_reuse){
						}else{
							cycle_round +=	DRAM_read_cyc*Q_ratio;
						}
						if(V_reuse){
						}else{
							cycle_round +=	DRAM_read_cyc*V_ratio;
						}
						round = max(reuse_round, cycle_round);;
					}
					
					mem_cycles += round;
					
				// actual_cycles += max(fused_sparse_cycles*1.0, 1.0*mem_cycles);
				int sparse_group = 1;
				int group = SSB/SB * SSH/SH * SSM/SM * (SSD+SSO)/(SD+SO) * SSE/SE;
				if(PhiSpargAttenTopK){
					sparse_group = PhiSpargAttenTopKRatio;
				}else{
					sparse_group = group;
				}
				sparse_group = min(sparse_group, group);
				
				// compute_cycles = 
				// mem_cycles = mem_cycles);
				// cout << fused_sparse_cycles << "\t" << mem_cycles << endl;
				
				// float alpha = 1.0;
				// if(WindowAttenComp){
				// 	int T = 128;
				// 	if(m+mmm >16 and (m +mmm < n+nnn-T or n+nnn+T < m+mmm)){
				// 		actual_cycles += mem_cycles;// alpha = 0.0;
				// 	}else{
				// 		actual_cycles += max(fused_sparse_cycles*1.0*sparse_group/group, 1.0*mem_cycles);
				// 	}
				// }else{
					actual_cycles += max(fused_sparse_cycles*1.0*sparse_group/group, 1.0*mem_cycles);
				// }
				// cout << "sparse group" << sparse_group << endl;
				
				// cout << "group" << group << endl;
				// return 0;
				// best_util   +=   
				
									
				// }}}}}}

		}}}}}}
		
		}}}	}
	// actual_cycles += ((DimB*DimN*DimD*DimH)/SO/SH/SB/SN)* DRAM_read_cyc;
	cout << "Fused Out " << actual_cycles/1e9  <<endl;		





	//Hardware mapping to hardware

	std::stringstream label;
	std::stringstream design;

	// string design = "";
	// design += 
	
	
	
	//1. high-level params
	design << H << "\t" << HH << "\t" << SH << "\t" << SSH << "\t"
		   << N << "\t" << NN << "\t" << SN << "\t" << SSN << "\t"
		   << B << "\t" << BB << "\t" << SB << "\t" << SSB << "\t"
		   << M << "\t" << MM << "\t" << SM << "\t" << SSM << "\t"
		   << D << "\t" << DD << "\t" << SD << "\t" << SSD << "\t"
		   << O << "\t" << OO << "\t" << SO << "\t" << SSO << "\t"
		   << PhiSpargAttenTopK << "\t" << PhiSpargAttenTopKRatio << "\t"
		   << PhiX << "\t"
		   << PhiW << "\t" 
		   
		   << PhiXMem << "\t" 
		   << PhiWMem << "\t" 
		   << WindowAttenComp << "\t" 
		   << WindowAttenMem << "\t" ;
	label << "H" << "\t" << "HH" << "\t" << "SH" << "\t" << "SSH" << "\t"
		   << "N" << "\t" << "NN" << "\t" << "SN" << "\t" << "SSN" << "\t"
		   << "B" << "\t" << "BB" << "\t" << "SB" << "\t" << "SSB" << "\t"
		   << "M" << "\t" << "MM" << "\t" << "SM" << "\t" << "SSM" << "\t"
		   << "D" << "\t" << "DD" << "\t" << "SD" << "\t" << "SSD" << "\t"
		   << "O" << "\t" << "OO" << "\t" << "SO" << "\t" << "SSO" << "\t"
		   << "PhiSpargAttenTopK" << "\t" << "PhiSpargAttenTopKRatio" << "\t"
		   << "PhiX" << "\t"
		   << "PhiW" << "\t" 
		   << "PhiXMem" << "\t" 
		   << "PhiWMem" << "\t" 
		   << "WindowAttenComp" << "\t" 
		   << "WindowAttenMem" << "\t" ;
				   
	//2. hardware params
	//0. PE array
	
	
	//1. SRAMs
	
	
	//2. Memory-group
	
	
	//2. Memory-value
	
	
	//2. Compute-group
	
	
	//2. Compute-value
	
	
	
	
	//3. Simulation results
	design << actual_cycles << "\t";
	label << "actual_cycles" << "\t";
	
    cout << label.str() <<endl;
	cout << design.str() <<endl;
	
	SimResult res;
	res.design = design.str();
	res.label = label.str();
	return res;//make_pair(label, design);
}

int main(){

	#if(MHABASE)
	
		int SG ;
		int SB ;
		int SN ;
		int SI ;
		
		int SM_SB ;
		int SM_SN ;
		int SM_SM ;

		int PhiX;
		int PhiW;
		
		//DSE SPACE
		SG = 2; SB = 1; SN = 64; SI = 64;
		SM_SB = 64;SM_SN=64; SM_SM=64;
		
		PhiX = 1;
		PhiW = 1;
		
		prefill_mha_baseline(
			SG    ,
			SB    ,
			SN    ,
			SI    ,
			SM_SB ,
			SM_SN ,
			SM_SM ,
			PhiX  ,
			PhiW  
		
		);
		cout<<endl;
	#endif
	
	
	#if(MHAFUSE)
	
	//Fused Operator Tiling + Loop Order
	int H = 1;	int HH = 1;	int SH = 1;	 int SSH = 1;  					int SHH = 1;
	int N = 1;	int NN = 1; int SN = 64;	 int SSN = 4;  int SNN = 512;
	int B = 1;  int BB = 1;	int SB = 1;  int SSB = 1;  					int SBB = 1;
	int M = 1;  int MM = 1; int SM = 1;   int SSM = 4;  int SMM = 512;
	int D = 1;  int DD = 1; int SD = 64;  int SSD = 1;  int SDD = 512;
	int O = 1;  int OO = 1; int SO = 64;  int SSO = 1; 					int SOO = 1;
	
	float thres = 0.4;
	float ratio = 0.5;
	
	int PhiX = 1;
	int PhiW = 1;
	int PhiRowXTopK = 1;  float PhiRowXTopKRatio = ratio;
	int PhiColWTopK = 1;  float PhiColWTopKRatio = ratio;
	int PhiRowXThres = 1; float PhiColXThresVal = 0.4;
	int PhiColWThres = 1; float PhiColWThresVal = 0.48;
	
	int PhiSpargAttenTopK = 1;  float PhiSpargAttenTopKRatio = ratio;
	int PhiSpargAttenThres = 1; float PhiSpargAttenThresVal = thres;
	
	int PhiXMem = 1;
	int PhiWMem = 1;
	int WindowAttenComp = 1;
	int WindowAttenMem = 1;
	
	// H = 1;	HH = H*1;	SH = HH*1;	 SSH = SH*1;  					
	// N = 1;	NN = N*1;   SN = NN*1;	 SSN = SN*4;   SNN = 512;
	// B = 1;  BB = B*1;   SB = BB*1;   SSB = SB*1;  					
	// M = 1;  MM = M*1;   SM = MM*4;   SSM = SM*4;   SMM = 512;
	// D = 1;  DD = D*1;   SD = DD*1;   SSD = SD*1;   SDD = 512;
	// O = 1;  OO = O*1;   SO = OO*1;   SSO = SO*1; 					
	
	H = 1;	HH = H*1;	SH = HH*1;	 SSH = SH*1;  					
	N = 1;	NN = N*32;   SN = NN*16;	 SSN = SN*4;   SNN = 512;
	B = 1;  BB = B*1;   SB = BB*1;   SSB = SB*1;  					
	M = 1;  MM = M*1;   SM = MM*1;   SSM = SM*4;   SMM = 512;
	D = 1;  DD = D*64;   SD = DD*1;   SSD = SD*1;   SDD = 512;
	O = 1;  OO = O*64;   SO = OO*1;   SSO = SO*1; 					
	
	
	D = 64;  DD = D*1;   SD = DD*1;   SSD = SD*1;   SDD = 512;
	D = 32;  DD = D*2;   SD = DD*1;   SSD = SD*1;   SDD = 512;
	D = 16;  DD = D*4;   SD = DD*1;   SSD = SD*1;   SDD = 512;
	D = 8;  DD = D*8;   SD = DD*1;   SSD = SD*1;   SDD = 512;
	D = 1;  DD = D*64;   SD = DD*1;   SSD = SD*1;   SDD = 512;
				
	
	// NOTE, SH 是 virtual , SSH 是 group virtual

	// //Tile 5
	SH = 8;	 SSH = SH*1;  					
	SN = 4;	 SSN = SN*4;   SNN = 512;
	SB = 4;   SSB = SB*1;  					
	SM = 4;   SSM = SM*4;   SMM = 512;
	SD = 8;   SSD = SD*1;   SDD = 512;
	SO = 8;   SSO = SO*1;

	HH = SH/1;	
	NN = SN/2;
	BB = SB/1;
	MM = SM/2;
	DD = SD/2;
	OO = SO/2;

	H = HH/1;
	N = NN/1;
	B = BB/1;
	M = MM/2;
	D = DD/4;
	O = OO/4;
		
	// #if(TILE5)
	// SH = 8;SN = 4;SB = 4;SM = 4;SO = 8;SD = 8;// SO = 64;
	// SNN = 64; SMM = 128; SDD = 128; SOO = 128;
	SNN = 256; SMM = 256; SDD = 256; SOO = 256;
	
	//Fused Operator Tiling	
	// SH = 1;SN = 64;SB = 1;SM = 1;SO = 64;SD = 64;// SO = 64;
	// SNN = 128; SMM = 128; SDD = 128; SOO = 128;
	
	// WindowAttenComp = 1;
	
	PhiX = 0;
	PhiW = 0;
	PhiSpargAttenTopK  = 0;  PhiSpargAttenTopKRatio = 4;
	PhiXMem = 0;
	PhiWMem = 0;
	WindowAttenMem = 0;	
	
	auto design = prefill_mha_fused(
	
		H ,  HH, SH,  SSH,  			//SHH = 1;
		N ,  NN, SN,  SSN,  SNN ,
		B ,  BB, SB,  SSB,  		//	SBB = 1;
		M ,  MM, SM,  SSM,  SMM ,
		D ,  DD, SD,  SSD,   SDD,
		O ,  OO, SO,  SSO, 			 	SOO,
		
		PhiRowXTopKRatio ,
		PhiColWTopKRatio ,
		PhiColXThresVal,
		PhiColWThresVal ,
		PhiSpargAttenTopKRatio,
		PhiSpargAttenThresVal ,

		//Sparse Set
		PhiX ,
		PhiW ,
		
		PhiRowXTopK ,
		PhiColWTopK ,
		PhiRowXThres,
		PhiColWThres,
		
		PhiSpargAttenTopK ,
		PhiSpargAttenThres,
		
		PhiXMem,
		PhiXMem,
		PhiWMem,
		
		WindowAttenComp ,
		WindowAttenMem
	
	);
	
	//Hardware Space
	//
	
	cout << design.label << endl;
	cout << design.design<<endl;
	cout<<endl;
	#endif
	
}