
#include <algorithm>
#include <iostream>
using namespace std;
#include <iostream>
#include <random>
#include <vector>
#include <algorithm>






//Everything computed in serial, because can only do so.
//With weight and value sparsity + data compression. (Stellar)
//Support caching
//Singular Fused-Operator,  KGen -> SRAM, VGen -> SRAM
int prefill_mha_baseline(){
	cout << "prefill_mha_baseline" << endl;
	//A transformer / QWen1 layer (prefill)
	
	//Workload
	
	int dModel = 32;
	int numHeads = 2;
	int Batch = 1;
	int Seq = 2;
	
	
	dModel = 1024;
	numHeads = 16;
	Batch = 4;
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
		

	float Xsp = 0.01; //..?
	float Wsp = 0.75; //..?
	
	float KVsp = 0.9; //basically dense
	float Qsp = 0.9; //basically dense
	float Psp = 0.2; //Can be very sparse due to softmax
	
	int sparsetype=ST;//1-uniform ,2- random, 3-unbalanced
	
	
	int sp_hw_type = 0;//Dense=0, SingleX, SingleW, Dual
	///////////////////////////////////////
	//matrix multiply
	int SG = 1; 
	int SB = 1;
	int SN = 64;
	int SI = 64;
	
	int SSG = 1;
	int SSB = 1;
	int SSN = 64;
	int SSI = 64;
	
	//Sparse Tiling
	int SpGG = 1;
	int SpBB = 1;
	int SpNN = 32;
	int SpII = 32;
	
	int SpG = 1;
	int SpB = 1;
	int SpN = 32;
	int SpI = 32;
	
	//Sparse Set
	int XSparse = 0;
	int YSparse = 0;
	int FullBlocked = 0;
	int XBlocked = 0;
	int YBlocked = 0;

	//0  --> //4
	//8  --> //4
	//Crossbar manual balancer
	//
	int balancer = NB;
	
	int MM_SBB = TILING;
	int MM_SGG = TILING;
	int MM_SNN = TILING;
	
	//softmax
	int SM_SB = 16;
	int SM_SN = 16;
	int SM_SM = 16;
	
	int SM_SNN = TILING;
	int SM_SMM = TILING;
	
	//Sparsity Set, i.e. Value-Memory and Value-Sparsity, no group sparsity or memory sparsity
	////////////////////////////////////////
	int DimB = Batch   ;
	int DimN = Seq     ;
	int DimH = numHeads    ;
	int DimM = Seq     ;
	int DimD = dModel  ;
	int DimE = dModel  ;
				
	#if(TILE1)
		SG = 1; SB = 128; SN = 64; SI = 1;
		SM_SB = 1;SM_SN=64; SM_SM=64;
	#endif
	
	#if(TILE2)
		SG = 1; SB = 1; SN = 32; SI = 32;
		SM_SB = 1;SM_SN=64; SM_SM=64;
	#endif
	
	
	#if(TILE3)
		SG = 1; SB = 64; SN = 1; SI = 128;
		SM_SB = 1;SM_SN=64; SM_SM=64;
	#endif
	
	#if(TILE4)
		SG = 4; SB = 64; SN = 32; SI = 1;
		SM_SB = 1;SM_SN=64; SM_SM=64;
	#endif
	
	#if(TILE6)
		SG = 1; SB = 1; SN = 4; SI = 4;
		SpGG = 1;
		SpBB = 1;
		SpNN = 4;
		SpII = 2;
		
		SpG = 1;
		SpB = 1;
		SpN = 1;
		SpI = 2;
		SM_SB = 1;SM_SN=64; SM_SM=64;
	#endif
	
	#if(TILE7)
		SG = 1; SB = 1; SN = 1; SI = 128;
		SpGG = 1;
		SpBB = 1;
		SpNN = 1;
		SpII = 64;
		
		SpG = 1;
		SpB = 1;
		SpN = 1;
		SpI = 64;
		SM_SB = 1;SM_SN=64; SM_SM=64;
	#endif
	
	#if(TILE8)
		SG = 1; SB = 1; SN = 32; SI = 8;
		SpGG = 1;
		SpBB = 1;
		SpNN = 8;
		SpII = 8;
		
		SpG = 1;
		SpB = 1;
		SpN = 8;
		SpI = 8;
		SM_SB = 1;SM_SN=64; SM_SM=64;
	#endif
	
	#if(TILE9)
		SG = 1; SB = 1; SN = 8; SI = 16;
		SpGG = 1;
		SpBB = 1;
		SpNN = 8;
		SpII = 8;
		
		SpG = 1;
		SpB = 1;
		SpN = 8;
		SpI = 8;
		SM_SB = 1;SM_SN=64; SM_SM=64;
		
		//Value Sparsity
		int sp_tiles[12] = {16,	16,	4,	4,	
						  4,	4,	4,	4,
						  4,    4,  4,  4};
		
		// int grp_tiles[3] = {};
		
		SSI = sp_tiles[0];
		SI = sp_tiles[1];
		SpII = sp_tiles[2];
		SpI = sp_tiles[3];
	
		SSN = sp_tiles[4];
		SN = sp_tiles[5];
		SpNN = sp_tiles[6];
		SpN = sp_tiles[7];
		
		SSB = sp_tiles[8];
		SB = sp_tiles[9];
		SpBB = sp_tiles[10];
		SpB = sp_tiles[11];
		
		
		
	#endif
	
	float scale = 1e9/1e12;
	float TFLOP_MM  =scale* SG*SB*SN*SI;   
	float TFLOP_SM  =scale* SM_SB*SM_SN*SM_SM;   

	cout << "TFLOPS " << TFLOP_MM+TFLOP_SM << endl;
	cout << "TFLOPS(MULT)" << TFLOP_MM<<endl;
	
	// return 0;
		
	
	//Value Sparsity Estimation
	//Workload type
	//1. Fully random
	//2. Structured
	//3. ,,,

	int Xtest  [SB*SI*SG];
	int Wtest  [SN*SI*SG];
	int Ptest  [SB*SI*SG];
	int KVtest [SN*SI*SG];
	int Qtest  [SB*SI*SG];
	
	
	//sp = 0 -> skip infinite
	//sp= 0.25 -> skip 4
	//sp = 0.5 -> 2
	//sp = 1.0 -> skip every (highest sparsity)
	int Xskip = 1/Xsp;
	int Wskip = 1/Wsp;
	int Pskip = 1/Psp;
	int KVskip = 1/KVsp;
	int Qskip = 1/Qsp;
	
	int sidx = 0;
	
	cout << "Xskip" << Xskip << endl;
	cout << "Wskip" << Wskip << endl;
	
	cout << "TILE" << SB*SG*SI << endl;
	
	//Sparsetype 2, random ordered generated zeros
    std::vector<int> Xindices(SB*SG*SI);
    std::vector<int> Pindices(SB*SG*SI);
	std::vector<int> Qindices(SB*SG*SI);
	for (int i = 0; i <= SB*SG*SI; ++i) {
		Xindices[i] = i;
		Pindices[i] = i;
		Qindices[i] = i;
	}
	
	std::vector<int> Windices(SN*SG*SI);
	std::vector<int> KVindices(SN*SG*SI);
	for (int i = 0; i <= SN*SG*SI; ++i) {
		Windices[i] = i;
		KVindices[i] = i;
	}
	
	std::random_device rd;
	std::mt19937 g(rd()); 
	std::shuffle(Xindices.begin(), Xindices.end(), g);
	std::shuffle(Pindices.begin(), Pindices.end(), g);
	std::shuffle(Qindices.begin(), Qindices.end(), g);
	std::shuffle(Windices.begin(), Windices.end(), g);
	std::shuffle(KVindices.begin(), KVindices.end(), g);


	std::vector<int> Xselected(Xindices.begin(), Xindices.begin() + (int) (SB*SG*SI*Xsp));
	std::vector<int> Pselected(Pindices.begin(), Pindices.begin() + (int) (SB*SG*SI*Psp));
	std::vector<int> Qselected(Qindices.begin(), Qindices.begin() + (int) (SB*SG*SI*Qsp));
	std::vector<int> Wselected(Windices.begin(), Windices.begin() + (int) (SN*SG*SI*Wsp));
	std::vector<int> KVselected(KVindices.begin(), KVindices.begin() + (int) (SN*SG*SI*KVsp));
		
	// for(auto wx : Wselected){
	// 	cout << wx <<endl;
	// }
	// return 0;
		
	// std::sort(Xselected.begin(), Xselected.end());
	
	for(int bb = 0; bb < SB; bb++){
	for(int mm = 0; mm < SG; mm++){
	for(int ee = 0; ee < SI; ee++){	
		sidx++;
		if(sparsetype==1){
			if(sidx % Xskip == 0){
				Xtest[bb + SB*(mm + SG*ee)] = 0;
			}else{
				Xtest[bb + SB*(mm + SG*ee)] = 1;
			}
			
			if(sidx % Pskip == 0){
				Ptest[bb + SB*(mm + SG*ee)] = 0;
			}else{
				Ptest[bb + SB*(mm + SG*ee)] = 1;
			}

			if(sidx % Qskip == 0){
				Qtest[bb + SB*(mm + SG*ee)] = 0;
			}else{
				Qtest[bb + SB*(mm + SG*ee)] = 1;
			}
					
		}
		
		if(sparsetype==2){
			auto it = std::find(Xselected.begin(), Xselected.end(), sidx);
			auto pit = std::find(Pselected.begin(), Pselected.end(), sidx);
			auto qit = std::find(Qselected.begin(), Qselected.end(), sidx);
    
			if (it != Xselected.end()) {
				Xtest[bb + SB*(mm + SG*ee)] = 0;
			}else{
				Xtest[bb + SB*(mm + SG*ee)] = 1;
			}
			
			
			if (pit != Pselected.end()) {
				Ptest[bb + SB*(mm + SG*ee)] = 0;
			}else{
				Ptest[bb + SB*(mm + SG*ee)] = 1;
			}
		
			if (qit != Qselected.end()) {
				Qtest[bb + SB*(mm + SG*ee)] = 0;
			}else{
				Qtest[bb + SB*(mm + SG*ee)] = 1;
			}
					
		}
		
		
		if(sparsetype==3){
			if(sidx < (int) (Xsp*SB*SG*SI)){
				Xtest[bb + SB*(mm + SG*ee)] = 0;
			}else{
				Xtest[bb + SB*(mm + SG*ee)] = 1;
			}
			
			if(sidx <(int) (Psp*SB*SG*SI) ){
				Ptest[bb + SB*(mm + SG*ee)] = 0;
			}else{
				Ptest[bb + SB*(mm + SG*ee)] = 1;
			}

			if(sidx < (int) (Qsp*SB*SG*SI) ){
				Qtest[bb + SB*(mm + SG*ee)] = 0;
			}else{
				Qtest[bb + SB*(mm + SG*ee)] = 1;
			}
					
		}		
		
		// sparsetype	
			
	}}}
	sidx = 0;
	cout << "TILE" << SN*SG*SI << endl;
	for(int bb = 0; bb < SN; bb++){
	for(int mm = 0; mm < SG; mm++){
	for(int ee = 0; ee < SI; ee++){	
		sidx++;
		// cout << "Widx" << bb + SN*(mm + SG*ee)<<endl;
		if(sparsetype==1){
			if(sidx % Wskip == 0){
				// cout << "add one";
				Wtest[bb + SN*(mm + SG*ee)] = 0;
			}else{
				Wtest[bb + SN*(mm + SG*ee)] = 1;
			}
			
			// cout << Wtest[bb + SN*(mm + SG*ee)]  <<endl;
			
			if(sidx % KVskip == 0){
				KVtest[bb + SN*(mm + SG*ee)] = 0;
			}else{
				KVtest[bb + SN*(mm + SG*ee)] = 1;
			}
					
		}	
		
		if(sparsetype==2){
			auto it = std::find(Wselected.begin(), Wselected.end(), sidx);
			auto pit = std::find(KVselected.begin(), KVselected.end(), sidx);
			
			if(it != Wselected.end()){
				// cout << "add one";
				Wtest[bb + SN*(mm + SG*ee)] = 0;
			}else{
				Wtest[bb + SN*(mm + SG*ee)] = 1;
			}

			if(pit != KVselected.end()){
				KVtest[bb + SN*(mm + SG*ee)] = 0;
			}else{
				KVtest[bb + SN*(mm + SG*ee)] = 1;
			}
					
		}
		
		if(sparsetype==3){
			// cout<<"sp3"<<endl;
			if(sidx <= (int) (SN*SG*SI*Wsp)){
				// cout << "add one";
				Wtest[bb + SN*(mm + SG*ee)] = 0;
			}else{
				Wtest[bb + SN*(mm + SG*ee)] = 1;
			}

			if(sidx <= (int)(SN*SG*SI*KVsp)){
				KVtest[bb + SN*(mm + SG*ee)] = 0;
			}else{
				KVtest[bb + SN*(mm + SG*ee)] = 1;
			}
					
		}		
		
		
		
	}}}	
	
	
	//Print check data
	
	// for(int bb = 0; bb < SN; bb++){
	// for(int mm = 0; mm < SG; mm++){
	// for(int ee = 0; ee < SI; ee++){	
	// 	cout<<Wtest[bb + SN*(mm + SG*ee)]<<endl;
	// }}}
	
	
	
	
	// return 0;
	
	//sparsity estimation
	float GenKQVValid = 0.0;
	float ScoreValid = 0.0;
	float SoftmaxValid = 0.0;
	float OutValid = 0.0;
	
	//Estimated sparse skipping
	int total = 0;
	int valid = 0;
	for(int bb = 0; bb < SB; bb++){
	for(int nn = 0; nn < SN; nn++){
	for(int mm = 0; mm < SG; mm++){
	for(int ee = 0; ee < SI; ee++){
		
		/////////////////
		//IDEAL case, get everything no stalls and imbalances
		//GenKQV
		// cout <<"xidx,Widx" << bb + SB*(mm + SG*ee)<<"\t"<<nn + SN*(mm + SG*ee) << endl;
		// cout << "X,W " << Xtest[bb + SB*(mm + SG*ee)]<<"\t"<<Wtest[nn + SN*(mm + SG*ee) ] << endl;
		if(Xtest[bb + SB*(mm + SG*ee)] == 0 | Wtest[nn + SN*(mm + SG*ee)] == 0 ){
			
		}else{
			GenKQVValid += 1;
		}
		if(Qtest[bb + SB*(mm + SG*ee)] == 0 | KVtest[nn + SN*(mm + SG*ee)] == 0 ){
			
		}else{
			ScoreValid += 1;
		}
		if(Ptest[bb + SB*(mm + SG*ee)] == 0 | KVtest[nn + SN*(mm + SG*ee)] == 0 ){
			
			OutValid += 1;
		}else{
		}
		
		
		SoftmaxValid+=1;//No sparsity support
		
		/////////////////
		//STALLED, consider micro tilings balancing case, get everything no stalls and imbalances
		//GenKQV
		
				
		total+=1 ;
		
	}}}}
	cout << "Xsp" << Xsp << endl;
	cout << "Wsp" << Wsp << endl;
	cout <<"GenKQVvalid" << (float) GenKQVValid/total<<endl;
	cout <<"ScoreValid" << (float) ScoreValid/total<<endl;
	cout <<"OutValid" << (float) OutValid/total<<endl;
	
	// cout << GenKQVValid<<endl;
	// cout << total<<endl;
	//Need to consider hardware constraints	
	// SG / SpG ;
	// SB / SpB ;
	// SN / SpN ;
	// SI / SpI ;
	int groups = SG*SB*SN;
	int elt    = SI;
	
	int GenKQVgrouped[groups][elt];
	for(int g = 0 ; g < groups; g++){
		for(int e = 0; e < elt; e++){
			GenKQVgrouped[g][e] = 0;
		}
	}
	
	for(int bb = 0; bb < SB; bb++){
	for(int nn = 0; nn < SN; nn++){
	for(int mm = 0; mm < SG; mm++){
	for(int ee = 0; ee < SI; ee++){
		
		//Emulate the data process
		//Based on different groups
		
		// for(int b = bb; b < bb+SB; b++){
		// for(int n = nn; n < nn+SN; n++){
		// for(int m = mm; m < mm+SG; m++){
		
		// for(int e = ee; e < ii+SI; e++){
		int gidx = mm + SG*(nn + SN*bb);
		int eidx = ee;
		// cout <<"xidx,Widx" << bb + SB*(mm + SG*ee)<<"\t"<<nn + SN*(mm + SG*ee) << endl;
		// cout << "X,W " << Xtest[bb + SB*(mm + SG*ee)]<<"\t"<<Wtest[nn + SN*(mm + SG*ee) ] << endl;
		// cout << gidx << endl;
		if( Xtest[bb + SB*(mm + SG*ee)] == 0 | Wtest[nn + SN*(mm + SG*ee)] == 0 ){
			
		}else{
			GenKQVgrouped[gidx][eidx] = 1;
		}			
		
		// total+=1 ;
		
	}}}}
	//N: 8:8 (0, 1, 2, 3, 4, 5 6) --> 8
	//N: 64:8 (0 1 2 3 4 5 6 7 8) --> Grouped together 
	int super_groups =  SB/SpBB  *SG/SpGG * SN/SpNN ;
	int super_elt = SI / SpI  ; // 8, 4 -> 2
	int pe_groups = SpBB/SpB * SpGG/SpG * SpNN/SpN;
	
	cout << "super_groups " << super_groups<<endl;
	cout << "groups " << groups<<endl;
	cout << "pe_groups " << pe_groups<<endl;
	
	int max_cyc = 0;
	
	
	cout << "SI\t" << SI << endl;
	cout << "SII\t" << SpII << endl;
	cout << "SN\t" << SN << endl;
	cout << "SpNN\t" << SpNN << endl;
	cout << "SpN\t" << SpN << endl;
	cout << "SN\t" << SB << endl;
	cout << "SpNN\t" << SpBB << endl;
	cout << "SpN\t" << SpB << endl;
	
	
	
	
	for(int gg = 0 ; gg < groups; gg += super_groups){
	int gp_count = 0;
	for(int g = gg ; g < gg+super_groups; g+=pe_groups){
		int count = 0;
		int dense_count = 0;
		for(int ggg = g ; ggg < g+pe_groups; ggg++){
			
			for(int e = 0; e < elt; e++){
				cout << gg<<"\t"<<g <<"\t"<< ggg << "\t" << e << endl;
			
				count += GenKQVgrouped[ggg][e] ;
				dense_count += 1;
				// cout << GenKQVgrouped[g][e]<<endl;
				
				
			}
		}
	}
	
	}
	
	return 0;
	
	for(int gg = 0 ; gg < groups; gg += super_groups){
		
	
	int gp_count = 0;
	for(int g = gg ; g < gg+super_groups; g+=pe_groups){
		int count = 0;
		int dense_count = 0;
		for(int ggg = g ; ggg < g+pe_groups; ggg++){
			
			for(int e = 0; e < elt; e++){
				// cout << g << "\t" << e << endl;
			
				count += GenKQVgrouped[ggg][e] ;
				dense_count += 1;
			// 	cout << GenKQVgrouped[g][e]<<endl;
				
			}
			// cout << "\tgg\t" << gg << "\tg\t" << g << endl;
		}
		
		// cout << "g\t" << g<<"\t"<< count<<"\ttotal\t" << elt <<"\t;";
		
		cout << "dense\t" << dense_count<<"\tsparse\t"<< count <<"\t;";
		
		// if(count == 0){
		// 		cout << elt << "\t" << 1 << endl;
		// }else{
		// 			cout << elt << "\t" << (count+super_elt-1)/super_elt << endl;
		// }
		int grp_cycles = (count+dense_count-1)/dense_count;
		cout << "group_cycles " << grp_cycles << endl;
		if(max_cyc < grp_cycles){
			max_cyc = grp_cycles;
		}
		// cout << total << "\t" << total/count << endl;
	}
	
		cout << endl;
	}
	
	float pes = SpBB * SpGG * SpNN;
	
	cout << "cycles per block" << max_cyc;
	cout << "dense cycles " << super_elt;
	cout << "scaled by size" << max_cyc/pes<<endl;
	
	return 0;
	
	
	
		
		
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












//Support caching
//Singular Fused-Operator,  KGen -> SRAM, VGen -> SRAM
//V1 - Homogenous tiling
int prefill_mha_fused(){
	///////////////////////////////////////
	//Reconfigurable Array
	//Full Set of Parameters
	//matrix multiply 
	
	//Physical Grouping
	//Physical Tiling
	//Virtual tiling
	//Group tiling
	//Secondary Tiling

	int H = 1;	int HH = 1;	int SH = 1;	 int SSH = 1;  					int SHH = 1;
	int N = 1;	int NN = 1; int SN = 1;	 int SSN = 4;  int SNN = 512;
	int B = 1;  int BB = 1;	int SB = 1;  int SSB = 1;  					int SBB = 1;
	int M = 1;  int MM = 1; int SM = 1;  int SSM = 4;  int SMM = 512;
	int D = 1;  int DD = 1; int SD = 1;  int SSD = 1;  int SDD = 512;
	int O = 1;  int OO = 1; int SO = 2;  int SSO = 1; 					int SOO = 1;


	float PhiRowXTopKRatio ;
	float PhiColWTopKRatio ;
	float PhiColXThresVal;
	float PhiColWThresVal ;
	float PhiSpargAttenTopKRatio;
	float PhiSpargAttenThresVal ;
			

	//Sparse Set
	int PhiX = 0;
	int PhiW = 0;
	
	int PhiRowXTopK = 0;
	int PhiColWTopK = 0;
	int PhiRowXThres = 0;
	int PhiColWThres = 0;
	
	
	int PhiSpargAttenTopK = 0;
	int PhiSpargAttenThres = 0;
	
	int PhiXMem = 0;
	int PhiWMem = 0;
	
	int WindowAttenComp = 0;
	int WindowAttenMem = 0;
	////////////////////////////////////////////
		
		// int TILINGS[][] = {
		// 	{1, 1, 1, 1,                        0}, //H
		// 	{1, 1, 1, 1, 1}, //N
		// 	{1, 1, 1, 1,                        0},//B
		// 	{1, 1, 1, 1, 1}, //M
		// 	{1, 1, 1, 1, 1}, //D
		// 	{1, 1, 1, 1, 						0}//O
		// };
		
		// int SMAPS[10] = {0,0,0,0
		// 			0,0,
		// 			0,0,
		// 			0,0};
		
		
		////////////////////////////////////////////////////////////////////////////
		H = 1;	HH = 2;	SH = 4;	 SSH = 8;  					
		N = 1;	NN = 2; SN = 4;	 SSN = 8;   SNN = 512;
		B = 1;  BB = 2; SB = 4;  SSB = 8;  					
		M = 1;  MM = 2; SM = 4;  SSM = 8;   SMM = 512;
		D = 1;  DD = 2; SD = 4;  SSD = 8;   SDD = 512;
		O = 1;  OO = 2; SO = 4;  SSO = 8; 					

		H = 1;	HH = H*1;	SH = HH*1;	 SSH = SH*1;  					
		N = 1;	NN = N*1;   SN = NN*1;	 SSN = SN*4;   SNN = 512;
		B = 1;  BB = B*1;   SB = BB*1;   SSB = SB*1;  					
		M = 1;  MM = M*1;   SM = MM*4;   SSM = SM*4;   SMM = 512;
		D = 1;  DD = D*1;   SD = DD*1;   SSD = SD*1;   SDD = 512;
		O = 1;  OO = O*1;   SO = OO*1;   SSO = SO*1; 					

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
								
								
		float thres = 0.4;
		float ratio = 0.5;
		
		PhiX = 1;
		PhiW = 1;
		PhiRowXTopK = 1; PhiRowXTopKRatio = ratio;
		PhiColWTopK = 1; PhiColWTopKRatio = ratio;
		PhiRowXThres = 1; PhiColXThresVal = 0.4;
		PhiColWThres = 1; PhiColWThresVal = 0.48;
		
		PhiSpargAttenTopK = 1; PhiSpargAttenTopKRatio = ratio;
		PhiSpargAttenThres = 1; PhiSpargAttenThresVal = thres;
		PhiXMem = 1;
		PhiWMem = 1;
		WindowAttenComp = 1;
		WindowAttenMem = 1;
				
		float Xsp = 0.5;
		float Wsp = 0.5;
		// float Psp = 0.0;
		// float KVsp = 0.1;
		// float Qsp = 0.1;
		

		float KVsp = 0.1; //basically dense
		float Qsp = 0.1; //basically dense
		float Psp = 0.2; //Can be very sparse due to softmax
	
		Wsp = 0.8;
		Xsp = 0.8;
		
		int sparsetype = 2;
		////////////////////////////////////////////////////////////////////////////////
		//
		
		// \item Data Value (PE + Mem) $\Phi = (W == 0)$, $\Phi = (X == 0)$
		// \item Row Value (PE) $\Phi = (Pool(X) < \delta)$, $\Phi = (Pool(W) < \delta)$
		// \item SpargAttention Group (PE) $\Phi = \text{TopK}(\text{Pool}(X)\text{Pool}(W))$
		// \item Threshold Group (PE) $\Phi = (\text{Pool}(X)\text{Pool}(W)) < \delta$
		// \item Window Group (PE + Mem) $\Phi = !(n < \beta\ \And  m-T<n<m) $
		
		// Input The input consists of the attention type (MHA, GQA,
		// MLA), fused-operator dataflow, and sparsity-related configurations.
		// Fused-operator dataflow parameters include loop order, tilings, sec-
		// ondary tilings, and scratchpad/cache sizes. An optional parameter
		// allows for cache optimization, which will try to reduce the cache
		// size to maximally fit the given workload under dense inference
		// conditions. Sparsity-related configurations include the sparsity set,
		// sparsity tilings, and the location of sparsity (compute or memory).
		
		/////////////////////////////////////////
	
	//Estimate Sparsity Statistics Patterns
	//Only need for Compute Sparsity
	
	//Value memory changes the cycles read
	//Value group changes the indices
	
	

		
		int Xtest [SSB*SSN*SSE];
		int Wtest [GSSD*SSE*SSH];
		// int Ptest  [SSB*SSI*SSG];
		int KVtest [SSB*SSM*SSD*SSH];
		int Qtest  [SSB*SSN*SSD*SSH];
		
		
		//sp = 0 -> skip infinite
		//sp= 0.25 -> skip 4
		//sp = 0.5 -> 2
		//sp = 1.0 -> skip every (highest sparsity)
		int Xskip = 1/Xsp;
		int Wskip = 1/Wsp;
		// int Pskip = 1/Psp;
		int KVskip = 1/KVsp;
		int Qskip = 1/Qsp;
		
		int sidx = 0;
		
		// cout << "Xskip" << Xskip << endl;
		// cout << "Wskip" << Wskip << endl;
		
		// cout << "TILE" << SB*SG*SI << endl;
		
		//Sparsetype 2, random ordered generated zeros
	    std::vector<int> Xindices(SSB*SSN*SSE);
	 //    std::vector<int> Pindices(SSB*SSG*SSI);
		std::vector<int> Qindices(SSN*GSSD*SSH*SSB);
		for (int i = 0; i <= SSB*SSN*SSE; ++i) {
			Xindices[i] = i;
			// Pindices[i] = i;
			// Qindices[i] = i;
		}
		
		for (int i = 0; i <= SSN*SSD*SSH*SSB; ++i) {
			Qindices[i] = i;
		}		
		
		
		std::vector<int> Windices(GSSD*SSE*SSH);
		std::vector<int> KVindices(SSM*SSD*SSH*SSB);
		for (int i = 0; i <= GSSD*SSE*SSH; ++i) {
			Windices[i] = i;	
		}
		
		for (int i = 0; i <= SSM*SSD*SSH*SSB; ++i) {
			KVindices[i] = i;	
		}		
		
		
		std::random_device rd;
		std::mt19937 g(rd()); 
		std::shuffle(Xindices.begin(), Xindices.end(), g);
		// std::shuffle(Pindices.begin(), Pindices.end(), g);
		std::shuffle(Qindices.begin(), Qindices.end(), g);
		std::shuffle(Windices.begin(), Windices.end(), g);
		std::shuffle(KVindices.begin(), KVindices.end(), g);
	
	
		std::vector<int> Xselected(Xindices.begin(), Xindices.begin() + (int) (Xindices.size()*Xsp));
		// std::vector<int> Pselected(Pindices.begin(), Pindices.begin() + (int) (SB*SG*SI*Psp));
		std::vector<int> Qselected(Qindices.begin(), Qindices.begin() + (int) (Qindices.size()*Qsp));
		std::vector<int> Wselected(Windices.begin(), Windices.begin() + (int) (Windices.size()*Wsp));
		std::vector<int> KVselected(KVindices.begin(), KVindices.begin() + (int) (KVindices.size()*KVsp));
			
		//SSB*SSN*SSE
		sidx = 0;
		cout << "Xindices sze "<< Xindices.size()<<endl;
		cout << "Xselected sze " << Xselected.size()<<endl;
		cout << "size " << ((float)Xindices.size()*(float)Xsp) << endl;
		
		
		cout << "Windices sze "<< Windices.size()<<endl;
		cout << "Wselected sze " << Wselected.size()<<endl;
		cout << "size " << ((float)Windices.size()*(float)Wsp) << endl;
		
		
		sidx = 0;
		for(int bb = 0; bb < SSB; bb++){
		for(int mm = 0; mm < SSN; mm++){
		for(int ee = 0; ee < SSE; ee++){	
			sidx++;
			// cout << "sparsetype\t" <<sparsetype << endl;
			if(sparsetype==2){
				auto it = std::find(Xselected.begin(), Xselected.end(), sidx);
				// cout << (it != Xselected.end()) << endl;
				if (it != Xselected.end()) {
					Xtest[bb + SSB*(mm + SSN*ee)] = 0;
				}else{
					Xtest[bb + SSB*(mm + SSN*ee)] = 1;
				}
	
			}
			
			if(sparsetype==3){
				if(sidx < (int) (Xsp*Xindices.size())){
					Xtest[bb + SSB*(mm + SSN*ee)] = 0;
				}else{
					Xtest[bb + SSB*(mm + SSN*ee)] = 1;
				}
						
			}		
			
			// sparsetype	
				
		}}}
		
		sidx = 0;
		for(int bb = 0; bb < SSB; bb++){
		for(int nn = 0; nn < SSN; nn++){
		for(int hh = 0; hh < SSH; hh++){
		for(int dd = 0; dd < SSD; dd++){
			sidx++;
			if(sparsetype==2){
				auto it = std::find(Qselected.begin(), Qselected.end(), sidx);
				if (it != Qselected.end()) {
					Qtest[bb + SSB*(nn + SSN*(hh + SSH*dd))] = 0;
				}else{
					Qtest[bb + SSB*(nn + SSN*(hh + SSH*dd))] = 1;
				}
			
			}
			
			if(sparsetype==3){
				if(sidx < (int) (Qsp*Qindices.size())){
					Qtest[bb + SSB*(nn + SSN*(hh + SSH*dd))] = 0;
				}else{
					Qtest[bb + SSB*(nn + SSN*(hh + SSH*dd))] = 1;
				}
						
			}		
			
			// sparsetype	
				
		}}}}
	
	
		
		sidx = 0;
		// cout << "TILE" << SN*SG*SI << endl;
	
		for(int bb = 0; bb < SSB; bb++){
		for(int mm = 0; mm < SSM; mm++){
		for(int hh = 0; hh < SSH; hh++){
		for(int dd = 0; dd < SSD; dd++){
			sidx++;
			if(sparsetype==2){
				auto it = std::find(KVselected.begin(), KVselected.end(), sidx);
				if (it != KVselected.end()) {
					KVtest[bb + SSB*(mm + SSM*(hh + SSH*dd))] = 0;
				}else{
					KVtest[bb + SSB*(mm + SSM*(hh + SSH*dd))] = 1;
				}
			
			}
			
			if(sparsetype==3){
				if(sidx < (int) (KVsp*KVindices.size())){
					KVtest[bb + SSB*(mm + SSM*(hh + SSH*dd))] = 0;
				}else{
					KVtest[bb + SSB*(mm + SSM*(hh + SSH*dd))] = 1;
				}
						
			}		
			
			// sparsetype	
				
		}}}}
		
		sidx = 0;
		//SSD*SSE*SSH
		for(int bb = 0; bb < GSSD; bb++){
		for(int mm = 0; mm < SSH; mm++){
		for(int ee = 0; ee < SSE; ee++){	
			sidx++;
			if(sparsetype==2){
				auto it = std::find(Wselected.begin(), Wselected.end(), sidx);
				// auto pit = std::find(KVselected.begin(), KVselected.end(), sidx);
				
				if(it != Wselected.end()){
					// cout << "add one";
					Wtest[bb + GSSD*(mm + SSH*ee)] = 0;
				}else{
					Wtest[bb + GSSD*(mm + SSH*ee)] = 1;
				}
						
			}
			
			if(sparsetype==3){
				// cout<<"sp3"<<endl;
				if(sidx <= (int) (Wselected.size()*Wsp)){
					// cout << "add one";
					Wtest[bb + GSSD*(mm + SSH*ee)] = 0;
				}else{
					Wtest[bb + GSSD*(mm + SSH*ee)] = 1;
				}		
			}		
		}}}	
			
		// delete Xindices;
		// delete Windices;
			
			
			
			
			
		// 	//Print check data
			
		// 	// for(int bb = 0; bb < SN; bb++){
		// 	// for(int mm = 0; mm < SG; mm++){
		// 	// for(int ee = 0; ee < SI; ee++){	
		// 	// 	cout<<Wtest[bb + SN*(mm + SG*ee)]<<endl;
		// 	// }}}
		int xzeros = 0;
		int xones = 0;
		int xtotal = 0;
		for(int bb = 0; bb < SSB; bb++){
		for(int mm = 0; mm < SSN; mm++){
		for(int ee = 0; ee < SSE; ee++){	
			xtotal ++;
			
			if(Xtest[bb + SSB*(mm + SSN*ee)] == 0){
				xzeros++;
			}else{
				xones++;
			}

			
				
		}}}
		cout << "x: " << xtotal << "\t" << xones << "\t" << xzeros << endl;
		xzeros = 0;
		xones = 0;
		xtotal = 0;
		for(int bb = 0; bb < SSB; bb++){
		for(int mm = 0; mm < SSN; mm++){
		for(int ee = 0; ee < SSE; ee++){	
			xtotal ++;
			
			if(Wtest[bb + GSSD*(mm + SSH*ee)] == 0){
				xzeros++;
			}else{
				xones++;
			}
	
				
		}}}
		cout << "w: " << xtotal << "\t" << xones << "\t" << xzeros << endl;
		
		
		// return 0;
			int qzeros = 0;
			int qones = 0;
			int qtotal = 0;
			for(int bb = 0; bb < SSB; bb++){
			for(int hh = 0; hh < SSH; hh++){
			for(int dd = 0; dd < SSD; dd++){
			for(int nn = 0; nn < SSN; nn++){		
				qtotal ++;
				
				if(Qtest[bb + SSB*(nn + SSN*(hh + SSH*dd))] == 0){
					qzeros++;
				}else{
					qones++;
				}
	
				
					
			}}}}
			cout << "Q: " << qtotal << "\t" << qones << "\t" << qzeros << endl;	
	
	
	
		int kvzeros = 0;
		int kvones = 0;
		int kvtotal = 0;
		for(int bb = 0; bb < SSB; bb++){
		for(int hh = 0; hh < SSH; hh++){
		for(int dd = 0; dd < SSD; dd++){
		for(int mm = 0; mm < SSM; mm++){		
			kvtotal ++;
			
			if( KVtest[bb + SSB*(mm + SSM*(hh + SSH*dd))]  == 0){
				kvzeros++;
			}else{
				kvones++;
			}
		
		}}}}
		cout << "KV: " << kvtotal << "\t" << kvones << "\t" << kvzeros << endl;	
		
	
			// return 0;
		
		
		
		////////////////////////////////////////////////////////////////////////////////////////////////
		// 	//sparsity estimation
		int dense_groups = 0;
		int dense_values = 0;
		int sparse_groups = 0;
		int sparse_groups_dense_values = 0;
		
		//1. Key-Value Generation
		float GenValueSparse = 0.0;	
		float GenGroupSparse = 0.0;
		
	
		// int groups = SG*SB*SN;
		// int elt    = SI;
		// //Value-Sparsity
		// int GenKQVgrouped[groups][elt];	
		
		//1.1 get group mask
		//Virtual Groups
		int virtualgroups = SSB/SB * SSN/SN *GSSD/GSD * SSH/SH * SE/EE; 
		cout << "virtual groups" << virtualgroups << endl;
		vector<float> groupmaskx(virtualgroups, 1); 
		vector<float> groupmaskw(virtualgroups, 1);
		vector<int> groupmask(virtualgroups, 0); //Skip?
		
		// int groupmask[4096];
		// for (int i =0 ; i < 4096; i++){
		// 	groupmask[i] = 0;
		// }
		
		
		// int groupmaskx[4096];
		// for (int i =0 ; i < 4096; i++){
		// 	groupmaskx[i] = 0;
		// }
		
		
		// int groupmaskw[4096];
		// for (int i =0 ; i < 4096; i++){
		// 	groupmaskw[i] = 0;
		// }
		
		// vector<int> groupdebug(virtualgroups, 0); 
		
		
		
		
		cout << "B " << SSB << "\t" << SB << endl;
		cout << "N " << SSN << "\t" << SN << endl;
		cout << "D " << GSSD << "\t" << GSD << endl;
		cout << "H " << SSH << "\t" << SH << endl;
		
		cout << "E " << SSE << "\t" << SE << endl;
		
		// return 0;
		int gidx = 0;
		for(int ssb = 0; ssb < SSB; ssb+=SB){
		for(int ssn = 0; ssn < SSN; ssn+=SN){
		for(int ssd = 0; ssd < GSSD; ssd+=GSD){
		for(int ssh = 0; ssh < SSH; ssh+=SH){
		for(int sse = 0; sse < SSE; sse+=SE){				
			float phirowx = 0;
			for(int sb = ssb; sb < ssb + SB; sb+=1){
			for(int sn = ssn; sn < ssn + SN; sn+=1){	
			// for(int sd = ssd; sd < ssd + GSD; sd+=1){
			// for(int sh = ssh; sh < ssh + SH; sh+=1){
			for(int se = sse; se < sse + SE; se+=1){				
				
				//Phi(B, NN, N, II, I )
				phirowx += Xtest[sb + SSB*(sn + SSN*se)]/(SE*SN*SB*1.0);
			
			}}}
			
			float phicolw = 0;
			// for(int sb = ssb; sb < ssb + SB; sb+=1){
			// for(int sn = ssn; sn < ssn + SN; sn+=1){	
			for(int sd = ssd; sd < ssd + GSD; sd+=1){
			for(int sh = ssh; sh < ssh + SH; sh+=1){
			for(int se = sse; se < sse + SE; se+=1){				
				
				//Phi(B, NN, N, II, I )
				phicolw += Wtest[sd + GSSD*(sh + SSH*se)]/(GSD*SH*SE*1.0);
			
			}}}
			
			
			// cout << "gidx\t" << gidx << "phirowx\t" << phirowx<< "\tphicolw\t" << phicolw<<endl;
			groupmaskx[gidx] = phirowx;
			groupmaskw[gidx] = phicolw;
			gidx ++;
		}}}}}
		
		gidx = 0;
		
		
		sort(groupmaskx.begin(), groupmaskx.end(), std::greater<float>());
		sort(groupmaskw.begin(), groupmaskw.end(), std::greater<float>());
		// sort(groupmaskx, groupmaskx + sizeof(groupmaskx) / sizeof(groupmaskx[0]), std::greater<float>());
		// sort(groupmaskw, groupmaskw + sizeof(groupmaskw) / sizeof(groupmaskw[0]), std::greater<float>());
								
		for(int ssb = 0; ssb < SSB; ssb+=SB){for(int ssn = 0; ssn < SSN; ssn+=SN){	for(int ssd = 0; ssd < GSSD; ssd+=GSD){for(int ssh = 0; ssh < SSH; ssh+=SH){for(int sse = 0; sse < SSE; sse+=SE){				

			// if(PhiRowXThres){
			// 	// cout << "gidx\t" << gidx << "\t" << groupmaskx[gidx] << "\t" << PhiColXThresVal << "\t" <<  ( groupmaskx[gidx] > PhiColXThresVal)<< endl;
			// 	groupmask[gidx] |= ( groupmaskx[gidx] < PhiColXThresVal);
			// }
			if(PhiRowXTopK){//Simple solution, just analytical
				// cout << "gidx\t" << gidx << "\t" << ( groupmaskx.size()*PhiRowXTopKRatio) << endl;
				groupmask[gidx] |= (gidx < (int) ( groupmaskx.size()*PhiRowXTopKRatio)  );
			}
			// if(PhiColWThres){
			// 	cout << "gidx\t" << gidx << "\t" << groupmaskw[gidx] << "\t" << PhiColWThresVal << "\t" 
			// 		<<  ( groupmaskw[gidx] < PhiColWThresVal)<< endl;
			// 	groupmask[gidx] |= ( groupmaskw[gidx] < PhiColWThresVal);
			// }
			if(PhiColWTopK){//Simple solution, just analytical
				// cout << "gidx\t" << gidx << "\t" << ( groupmaskx.size()*PhiRowXTopKRatio) << endl;
				groupmask[gidx] |= (gidx < (int) (   groupmaskw.size()*PhiColWTopKRatio)  );
			}
			// cout << groupmask[gidx] << endl;
			gidx ++;
		}}}}}
		// for(auto gm : groupmask){
		// 	cout << gm << endl;
		// }
		



		//1.2 get Value mask
		//Virtual Groups
		int virtualvalues = SB * SN * GSD* SH* SE; 
		vector<int> valuemaskx(virtualvalues, 1); 
		vector<int> valuemaskw(virtualvalues, 1);
		vector<int> valuemask(virtualvalues, 0); //Skip?
		
		// int valuemaskx[4096];
		// int valuemaskw[4096];
		// int valuemask[4096];
		
		// vector<int> valuedebug(virtualvalues, 0); 
		
		int ssb = 0;
		int ssd = 0;
		int ssh = 0;
		int sse = 0;
		int ssn = 0;
		gidx = 0;
		for(int sb = ssb; sb < ssb + SB; sb+=1){for(int sn = ssn; sn < ssn + SN; sn+=1){	
			for(int sd = ssd; sd < ssd + GSD; sd+=1){for(int sh = ssh; sh < ssh + SH; sh+=1){
				for(int se = sse; se < sse + SE; se+=1){
			int phirowx = 0;
			// for(int bb = 0; bb < sd + BB; bb+=1){
			// for(int nn = 0; nn < sd + NN; nn+=1){	
			// // for(int dd = 0; dd < sd + GDD; dd+=GD){
			// // for(int hh = 0; hh < sd + HH; hh+=H){
			// for(int ee = 0; ee < se + EE; ee+=1){			
				//Phi(B, NN, N, II, I )
				phirowx = Xtest[sb + SSB*(sn + SSN*se)];
			
			// }}}

			int phicolw = 0;
			// for(int bb = 0; bb < sd + BB; bb+=B){
			// for(int nn = 0; nn < sd + NN; nn+=N){	
			// for(int dd = 0; dd < sd + GDD; dd+=GD){
			// for(int hh = 0; hh < sd + HH; hh+=H){
			// for(int ee = 0; ee < se + EE; ee+=E){			
				//Phi(B, NN, N, II, I )
				phicolw = Wtest[sd + GSSD*(sh + SSH*se)];
			// }}}
			
			// cout << "value gidx\t" << gidx << "phirowx\t" << phirowx<< "\tphicolw\t" << phicolw<<endl;
			valuemaskx[gidx] = phirowx;
			valuemaskw[gidx] = phicolw;
			// cout << gidx << "\tvaluemask\t" << valuemask[gidx] << "\tvaluemaskx[gidx]\t" << valuemaskx[gidx]<<"\t"<<endl;
			 
			gidx ++;			
			
		}}}}} 
		
		cout << "done" << endl;
		gidx = 0;
		// sort(valuemaskx.begin(), valuemaskx.end(), std::greater<int>());
		// sort(valuemaskw.begin(), valuemaskw.end(), std::greater<int>());
		ssb = 0;
		ssd = 0;
		ssh = 0;
		sse = 0;
		ssn = 0;
		int skips = 0;
		for(int sb = ssb; sb < ssb + SB; sb+=1){for(int sn = ssn; sn < ssn + SN; sn+=1){	
			for(int sd = ssd; sd < ssd + GSD; sd+=1){for(int sh = ssh; sh < ssh + SH; sh+=1){
				for(int se = sse; se < sse + SE; se+=1){
					
					
					
			if(PhiX){
				// cout << "gidx\t" << gidx << "\t" << groupmaskx[gidx] << "\t" << PhiColXThresVal << "\t" <<  ( groupmaskx[gidx] > PhiColXThresVal)<< endl;
				valuemask[gidx] |= ( valuemaskx[gidx] == 0);
			}
			if(PhiW){
				// cout << "gidx\t" << gidx << "\t" << groupmaskw[gidx] << "\t" << PhiColWThresVal << "\t" 
					// <<  ( groupmaskw[gidx] > PhiColWThresVal)<< endl;
				valuemask[gidx] |= ( valuemaskw[gidx] == 0);
			}
			
			
			// cout << "valuemask\t" << valuemask[gidx] << "valuemaskx[gidx]" << valuemaskx[gidx]<<"\t"
			 
			// 	<< "valuemaskw[gidx]" << valuemaskw[gidx] << endl;
			
			if(valuemask[gidx]){
				skips ++;
			} 
			
			gidx ++;
		}}}}}
		// cout << "valuemask" << endl;
		// for(auto gm : valuemask){
		// 	cout << gm << endl;
		// }
		

		
		
		cout << "Value sparsity " << endl;
		cout << "skips " << skips << endl;
		cout << "total " << gidx << endl;


		
		
		
		
		//Have valuemask and groupmask
		//Group mask is simple to implement (see below)
		//Value mask more difficult, constrained by hardware.
		//get average
		
		
		//Virtual Tile
		int dense_cycles_value = 0;
		int valuesparse_max_groups = SB/BB * SN/NN * GSD/GDD * SH/HH* SE/EE; 
		cout << "valuesparse_max_groups\t" << valuesparse_max_groups << endl;
		// vector<int> sp_cycles_value(valuesparse_max_groups, 0);
		int grouped_sparse_cycles[1024];
		int sparse_cycles_value[1024];
		int spidx = 0;
		//Best reduction (i.e. SB/BB)
		
		int valgroup;
		
		//Collect statistics on the input of crossbar first
		//First each crossbar assuming non grouped (only over SE, EE)
		//Then over groupings
		
		gidx = 0;
		int dense_need = 0;
		for(int sb = 0; sb < 0 + SB; sb+=1){
		for(int sn = 0; sn < 0 + SN; sn+=1){	
		for(int sd = 0; sd < 0 + GSD; sd+=1){
		for(int sh = 0; sh < 0 + SH; sh+=1){
	
			//This many groups
			//Evaluate cycles for each
	
			int need = 0;
			for(int se = 0; se < 0 + SE; se+=1){							
				//Physical Tile	
				need += (1-valuemask[gidx]);		
				gidx++;
			}
			cout << spidx << "\tneed\t" << need << "\tdense\t" << SE << endl;
			cout << spidx << "\tneed\t" << need/(float) EE << "\tdense\t" << SE/(float) EE << endl;
			sparse_cycles_value[spidx] = need;
			// dense_need += SE;
			spidx++;
		}}}} 
		
		cout << "total groups\t" << spidx << endl;
		//Based on groups
		int grouped_sparse_cycles_max = 0;
		spidx = 0;
		for(int sb = 0; sb < 0 + SB; sb+=(BB/B)){
		for(int sn = 0; sn < 0 + SN; sn+=(NN/N)){	
		for(int sd = 0; sd < 0 + GSD; sd+=(GDD/GD)){
		for(int sh = 0; sh < 0 + SH; sh+=(HH/H)){
			
			//Grouping
	
			int dense_need = 0;
			for(int bb = sb; bb < sb + (BB/B); bb+=1){
			for(int nn = sn; nn < sn + (NN/N); nn+=1){	
			for(int dd = sd; dd < sd + (GDD/GD); dd+=1){
			for(int hh = sh; hh < sh + (HH/H); hh+=1){
			
				grouped_sparse_cycles[spidx] += sparse_cycles_value[hh + SH*(dd +  GSD*(nn  + SN*bb) ) ];
				 // dense_need += SE;
			}}}}		
			
			//Tile per group
			int tiles = EE *BB * NN * DD * HH;
			int tiles_per_group = tiles / (BB/B * NN/N * DD/D * HH/H);
			int grouped_total = SE*SB*SN*GSD*SH/(BB/B * NN/N * DD/D * HH/H);
			// cout << "" << spidx << "grouped_sparse_cycles " << grouped_sparse_cycles[spidx] << "\ttotal\t" << SE*SB*SN*GSD*SH << "\tgrouped total\t" <<
			// 	grouped_total  << endl;
			// // cout << "tiles " << EE *BB * NN * DD * HH << endl;
			// cout << "tiles_per_group\t" << tiles_per_group << endl;
			// cout << "needed cycles per round\t" << grouped_sparse_cycles[spidx]/tiles_per_group << "\tdense case\t" << SE*SB*SN*GSD*SH/(EE *BB * NN * DD * HH) << endl;
			// sp_cycles_value[spidx] = 
			// dense_case = SE*SB*SN*GSD*SH/(EE *BB * NN * DD * HH);
			
			if(grouped_sparse_cycles_max < grouped_sparse_cycles[spidx]/tiles_per_group){
				grouped_sparse_cycles_max = grouped_sparse_cycles[spidx]/tiles_per_group;
			}
			spidx++;
			
		}}}}
		
		cout << endl;
		cout << "SPARSITY ANALYSIS RESULTS: " << endl;
		int dense_case =  SE*SB*SN*GSD*SH/(EE *BB * NN * DD * HH);
		cout << "value sparsity saved cycles " << grouped_sparse_cycles_max<< "\tdense case\t"  << dense_case << endl; 
		if(grouped_sparse_cycles_max == 0){
			grouped_sparse_cycles_max = dense_case;
		}
		cout << "Value sparse speedup\t " << (float) dense_case/grouped_sparse_cycles_max << endl;

		//Time Simulation
		//Group Tile
		gidx = 0;
		for(int ssb = 0; ssb < SSB; ssb+=SB){
		for(int ssn = 0; ssn < SSN; ssn+=SN){	
		for(int ssd = 0; ssd < GSSD; ssd+=GSD){
		for(int ssh = 0; ssh < SSH; ssh+=SH){
		for(int sse = 0; sse < SSE; sse+=SE){				
			
			//Group sparsity
			if(groupmask[gidx]){
				sparse_groups += 0;
			}else{
				sparse_groups += 1;
				sparse_groups_dense_values += virtualgroups;
			}
			gidx ++;
			dense_groups += 1;
			dense_values += virtualgroups ;
			
			
			//Value Sparsity Mapping
			
			
			
			//Virtual Tile
			for(int sb = ssb; sb < ssb + SB; sb+=BB){
			for(int sn = ssn; sn < ssn + SN; sn+=NN){	
			for(int sd = ssd; sd < ssd + GSD; sd+=GDD){
			for(int sh = ssh; sh < ssh + SH; sh+=HH){
			for(int se = sse; se < sse + SE; se+=EE){				
				
				//Value Sparsity
				
				

				// total+=1 ;
				// if( Xtest[bb + SB*(mm + SG*ee)] == 0 | Wtest[nn + SN*(mm + SG*ee)] == 0 ){
					
				// }else{
				// 	GenKQVgrouped[gidx][eidx] = 1;
				// }			
					
				//Physical Tile
				for(int bb = 0; bb < sd + BB; bb+=B){
				for(int nn = 0; nn < sd + NN; nn+=N){	
				for(int dd = 0; dd < sd + GDD; dd+=GD){
				for(int hh = 0; hh < sd + HH; hh+=H){
				for(int ee = 0; ee < se + EE; ee+=E){				
					
					
					 
		
			}}}}} 
			
			
		}}}}} 
		
			// if(Xtest[bb + SSB*(mm + SSN*ee)] == 0 | Wtest[bb + SSD*(mm + SSH*ee)] == 0 ){
				
			// }else{
			// 	GenKQVValid += 1;
			// }
					
		}}}}} 	
		
		cout << "dense_values\t" << dense_values << endl;
		cout << "dense_groups\t" << dense_groups << endl;
		
		cout << "sparse_groups\t" << sparse_groups << endl;
		cout << "sparse_groups_dense_values\t" << sparse_groups_dense_values << endl;
		// cout << dense_groups/sparse_groups << endl;
		
		// cout << dense_groups/sparse_groups << endl;
		if(sparse_groups == 0){
			sparse_groups = dense_groups;
		}
		
		if(sparse_groups_dense_values == 0){
			sparse_groups_dense_values = dense_values;
		}
		cout << "group speedup\t" << dense_groups/sparse_groups <<endl;
		cout << "group dense value speedup\t" << dense_values/sparse_groups_dense_values<<endl;
		// cout << "total\t" << total<<endl;
		// cout << "Xsp\t" << Xsp << endl;
		// cout << "Wsp\t" << Wsp << endl;
		// cout <<"GenKQVvalid\t" << (float) GenKQVValid/total<<endl;
		// // cout <<"ScoreValid" << (float) ScoreValid/total<<endl;
		// cout <<"OutValid" << (float) OutValid/total<<endl;
		
		//Results
		float KVQGenGroupSpeedup = (float) dense_values/sparse_groups_dense_values;
		float KVQGenValueSpeedup = (float) dense_case/grouped_sparse_cycles_max;
		
		cout << "KVQGenGroupSpeedup\t"  <<  KVQGenGroupSpeedup << endl;
		cout << "KVQGenValueSpeedup\t" <<   KVQGenValueSpeedup << endl;
		cout << endl;
		cout << endl;
		return 1;
		
		
		
		//////////////////////////////////////////////////////////////////////////////
		///////////////////////////////////////////////////////////////////////////////////////////////
		//2. Score Generation
		float ScoreValid = 0.0;
		
		cout << "SCORE GENERATIONO " << endl;
		//get group mask
		//Virtual Groups
		virtualgroups = SSB/SB * SSN/SN *SSM/SM * SSH/SH * SSD/SD ; //Assume time is determined by the score calculation
		cout << "virtual groups" << virtualgroups << endl;
		vector<float> sc_groupmaskx(virtualgroups, 1); 
		vector<float> sc_groupmaskw(virtualgroups, 1);
		vector<int> sc_groupmask(virtualgroups, 0); //Skip?	
		// return 1;
		gidx = 0;
		for(int ssb = 0; ssb < SSB; ssb+=SB){
		for(int ssn = 0; ssn < SSN; ssn+=SN){
		for(int ssm = 0; ssm < SSM; ssm+=SM){
		for(int ssh = 0; ssh < SSH; ssh+=SH){
		for(int ssd = 0; ssd < SSD; ssd+=SD){
			
			
			float phirowx = 0;
			for(int sb = ssb; sb < ssb + SB; sb+=1){
			for(int sh = ssh; sh < ssh + SH; sh+=1){
			for(int sn = ssn; sn < ssn + SN; sn+=1){
			for(int sd = ssd; sd < ssd + SD; sd+=1){				
				//Phi(B, NN, N, II, I )
				
				phirowx += Qtest[sb + SSB*(sn + SSN*(sh + SSH*sd))] /(SD*SH*SN*SB*1.0);
			}}}}
			
			float phicolw = 0;
			for(int sb = ssb; sb < ssb + SB; sb+=1){
			for(int sh = ssh; sh < ssh + SH; sh+=1){
			for(int sm = ssm; sm < ssm + SM; sm+=1){
			for(int sd = ssd; sd < ssd + SD; sd+=1){					
							
				//Phi(B, NN, N, II, I )
				phicolw += KVtest[sb + SSB*(sm + SSM*(sh + SSH*sd))]/(SD*SH*SM*SB*1.0);
			}}}}
			
			cout << "gidx\t" << gidx << "phirowx\t" << phirowx<< "\tphicolw\t" << phicolw<<endl;
			// sc_groupmaskx[gidx] = phirowx*phicolw; 
			// sc_groupmaskw[gidx] = phicolw; 
			
			gidx ++;
		}}}}}
		
		gidx = 0;
		
		
		sort(sc_groupmaskx.begin(), sc_groupmaskx.end(), std::greater<float>());
		// sort(sc_groupmaskw.begin(), sc_groupmaskw.end(), std::greater<float>());
		// sort(groupmaskx, groupmaskx + sizeof(groupmaskx) / sizeof(groupmaskx[0]), std::greater<float>());
		// sort(groupmaskw, groupmaskw + sizeof(groupmaskw) / sizeof(groupmaskw[0]), std::greater<float>());
								
		for(int ssb = 0; ssb < SSB; ssb+=SB){
		for(int ssn = 0; ssn < SSN; ssn+=SN){
		for(int ssm = 0; ssm < SSM; ssm+=SM){
		for(int ssh = 0; ssh < SSH; ssh+=SH){
		for(int ssd = 0; ssd < SSD; ssd+=SD){
			
			
			// PhiSpargAttenTopK = 1; PhiSpargAttenTopKRatio = ratio;
			// PhiSpargAttenThres = 1; PhiSpargAttenThresVal = thres;
			
			if(PhiSpargAttenThres){
				// cout << "gidx\t" << gidx << "\t" << sc_groupmaskx[gidx] << "\t" << PhiSpargAttenThresVal << "\t"
				 // <<  ( sc_groupmaskx[gidx] < PhiSpargAttenThresVal) << endl;
				sc_groupmask[gidx] |= ( sc_groupmaskx[gidx] < PhiSpargAttenThresVal);
			}
			if(PhiSpargAttenTopK){//Simple solution, just analytical
				// cout << "gidx\t" << gidx << "\t" << ( groupmaskx.size()*PhiRowXTopKRatio) << endl;
				sc_groupmask[gidx] |= (gidx < (int) ( sc_groupmask.size()*PhiSpargAttenTopKRatio)  );
			}

			// cout << groupmask[gidx] << endl;
			gidx ++;
		}}}}}
		// for(auto gm : sc_groupmask){
		// 	cout << gm << endl;
		// }
		

	// 	//1.2 get Value mask
	// 	//Virtual Groups
		virtualvalues = SB * SN * SH* SM* SD; 
		vector<int> sc_valuemaskx(virtualvalues, 1); 
		vector<int> sc_valuemaskw(virtualvalues, 1);
		vector<int> sc_valuemask(virtualvalues, 0); //Skip?
		
		ssb = 0;
		ssd = 0;
		ssh = 0;
		sse = 0;
		ssn = 0;
		int ssm =0;
		gidx = 0;
		for(int sb = ssb; sb < ssb + SB; sb+=1){
		for(int sn = ssn; sn < ssn + SN; sn+=1){	
		for(int sm = ssm; sm < ssm + SM; sm+=1){
		for(int sh = ssh; sh < ssh + SH; sh+=1){
		for(int sd = ssd; sd < ssd + SD; sd+=1){
			int phirowx = 0;
			phirowx =Qtest[sb + SSB*(sn + SSN*(sh + SSH*sd))];
			
			int phicolw = 0;
			phicolw = KVtest[sb + SSB*(sm + SSM*(sh + SSH*sd))];
			sc_valuemaskx[gidx] = phirowx;
			sc_valuemaskw[gidx] = phicolw;
			gidx ++;			
			
		}}}}} 
		
		cout << "done" << endl;
		gidx = 0;
		// sort(valuemaskx.begin(), valuemaskx.end(), std::greater<int>());
		// sort(valuemaskw.begin(), valuemaskw.end(), std::greater<int>());
		ssb = 0;
		ssd = 0;
		ssh = 0;
		sse = 0;
		ssn = 0;
		ssm = 0;
		// int ssm = 0;
		// int ssd = 0;
		skips = 0;
		
		gidx = 0;
		for(int sb = ssb; sb < ssb + SB; sb+=1){
		for(int sn = ssn; sn < ssn + SN; sn+=1){	
		for(int sm = ssm; sm < ssm + SM;sm+=1){
		for(int sh = ssh; sh < ssh + SH; sh+=1){
		for(int sd = ssd; sd < ssd + SD; sd+=1){
			if(PhiX){
				// cout << "gidx\t" << gidx << "\t" << groupmaskx[gidx] << "\t" << PhiColXThresVal << "\t" <<  ( groupmaskx[gidx] > PhiColXThresVal)<< endl;
				sc_valuemask[gidx] |= ( sc_valuemaskx[gidx] == 0);
			}
			if(PhiW){
				// cout << "gidx\t" << gidx << "\t" << groupmaskw[gidx] << "\t" << PhiColWThresVal << "\t" 
					// <<  ( groupmaskw[gidx] > PhiColWThresVal)<< endl;
				sc_valuemask[gidx] |= ( sc_valuemaskw[gidx] == 0);
			}
			
			
			cout << "valuemask\t" << valuemask[gidx] <<endl;
			
			if(sc_valuemask[gidx]){
				skips ++;
			} 
			
			gidx ++;
		}}}}}
		// cout << "valuemask" << endl;
		// for(auto gm : valuemask){
		// 	cout << gm << endl;
		// }
		

		
		
		cout << "Value sparsity " << endl;
		cout << "skips " << skips << endl;
		cout << "total " << gidx << endl;


		
		//Virtual Tile
		// int dense_cycles_value = 0;
		// int valuesparse_max_groups = SB/BB * SN/NN * GSD/GDD * SH/HH* SE/EE; 
		// cout << "valuesparse_max_groups\t" << valuesparse_max_groups << endl;
		// vector<int> sp_cycles_value(valuesparse_max_groups, 0);
		grouped_sparse_cycles[4096];
		sparse_cycles_value[4096];
		spidx = 0;
		//Best reduction (i.e. SB/BB)
		
		valgroup;
		
		//Collect statistics on the input of crossbar first
		//First each crossbar assuming non grouped (only over SE, EE)
		//Then over groupings
		
		gidx = 0;
		dense_need = 0;
	// 	for(int sb = 0; sb < 0 + SB; sb+=1){
	// 	for(int sn = 0; sn < 0 + SN; sn+=1){	
	// 	for(int sd = 0; sd < 0 + GSD; sd+=1){
	// 	for(int sh = 0; sh < 0 + SH; sh+=1){
	
	
		for(int sb = 0; sb < 0 + SB; sb+=1){	
		for(int sn = 0; sn < 0 + SN; sn+=1){
		for(int sm = 0; sm < 0 + SM; sm+=1){
		for(int sh = 0; sh < 0 + SH; sh+=1){
			
			
			//This many groups
			//Evaluate cycles for each
	
			int need = 0;
			// for(int se = 0; se < 0 + SE; se+=1){		
			for(int sd = 0; sd < 0 + SD; sd+=1){
					
				//Physical Tile	
				need += (1-valuemask[gidx]);		
				gidx++;
			}
			// cout << spidx << "\tneed\t" << need << "\tdense\t" << SE << endl;
			// cout << spidx << "\tneed\t" << need/(float) EE << "\tdense\t" << SE/(float) EE << endl;
			sparse_cycles_value[spidx] = need;
			// dense_need += SE;
			spidx++;
		}}}} 
		
		
		
		cout << "total groups\t" << spidx << endl;
	// 	//Based on groups
		grouped_sparse_cycles_max = 0;
		spidx = 0;
		// for(int sb = 0; sb < 0 + SB; sb+=(BB/B)){
		// for(int sn = 0; sn < 0 + SN; sn+=(NN/N)){	
		// for(int sd = 0; sd < 0 + GSD; sd+=(GDD/GD)){
		// for(int sh = 0; sh < 0 + SH; sh+=(HH/H)){

		for(int sb = 0; sb < 0 + SB; sb+=(BB/B)){
		for(int sn = 0; sn < 0 + SN; sn+=(NN/N)){
		for(int sm = 0; sm < 0 + SM; sm+=(MM/M)){
		for(int sh = 0; sh < 0 + SH; sh+=(HH/H)){
		// for(int sd = 0; sd < 0 + SH; sd+=(DD/D)){
			
			//Grouping
	
			dense_need = 0;
			
			// for(int bb = sb; bb < sb + (BB/B); bb+=1){
			// for(int nn = sn; nn < sn + (NN/N); nn+=1){	
			// for(int dd = sd; dd < sd + (GDD/GD); dd+=1){
			// for(int hh = sh; hh < sh + (HH/H); hh+=1){

		for(int bb = sb; bb < sb + (BB/B); bb+=1){
		for(int nn = sn; nn < sn + (NN/N); nn+=1){	
		for(int mm = sm; mm < sm + (MM/M); mm+=1){	
		for(int hh = sh; hh < sh + (HH/H); hh+=1){
			
			
				grouped_sparse_cycles[spidx] += sparse_cycles_value[hh + SH*(mm +  SM*(nn  + SN*bb) ) ];
				 // dense_need += SE;
			}}}}		
			
			//Tile per group
			int tiles = EE *BB * NN * DD * HH;
			int tiles_per_group = tiles / (BB/B * NN/N * DD/D * HH/H);
			int grouped_total = SE*SB*SN*GSD*SH/(BB/B * NN/N * DD/D * HH/H);
			// cout << "" << spidx << "grouped_sparse_cycles " << grouped_sparse_cycles[spidx] << "\ttotal\t" << SE*SB*SN*GSD*SH << "\tgrouped total\t" <<
			// 	grouped_total  << endl;
			// // cout << "tiles " << EE *BB * NN * DD * HH << endl;
			// cout << "tiles_per_group\t" << tiles_per_group << endl;
			// cout << "needed cycles per round\t" << grouped_sparse_cycles[spidx]/tiles_per_group << "\tdense case\t" << SE*SB*SN*GSD*SH/(EE *BB * NN * DD * HH) << endl;
			// sp_cycles_value[spidx] = 
			// dense_case = SE*SB*SN*GSD*SH/(EE *BB * NN * DD * HH);
			
			if(grouped_sparse_cycles_max < grouped_sparse_cycles[spidx]/tiles_per_group){
				grouped_sparse_cycles_max = grouped_sparse_cycles[spidx]/tiles_per_group;
			}
			spidx++;
			
		}}}}
		
		cout << endl;
		cout << "SPARSITY ANALYSIS RESULTS: " << endl;
		dense_case =  SE*SB*SN*GSD*SH/(EE *BB * NN * DD * HH);
		cout << "value sparsity saved cycles " << grouped_sparse_cycles_max<< "\tdense case\t"  << dense_case << endl; 
		if(grouped_sparse_cycles_max == 0){
			grouped_sparse_cycles_max = dense_case;
		}
		cout << "Value sparse speedup\t " << (float) dense_case/grouped_sparse_cycles_max << endl;

	// 	//Time Simulation
	// 	//Group Tile
	// 	gidx = 0;
	// 	for(int ssb = 0; ssb < SSB; ssb+=SB){
	// 	for(int ssn = 0; ssn < SSN; ssn+=SN){	
	// 	for(int ssd = 0; ssd < GSSD; ssd+=GSD){
	// 	for(int ssh = 0; ssh < SSH; ssh+=SH){
	// 	for(int sse = 0; sse < SSE; sse+=SE){				
			
	// 		//Group sparsity
	// 		if(groupmask[gidx]){
	// 			sparse_groups += 0;
	// 		}else{
	// 			sparse_groups += 1;
	// 			sparse_groups_dense_values += virtualgroups;
	// 		}
	// 		gidx ++;
	// 		dense_groups += 1;
	// 		dense_values += virtualgroups ;
			
			
	// 		//Value Sparsity Mapping
			
			
			
	// 		//Virtual Tile
	// 		for(int sb = ssb; sb < ssb + SB; sb+=BB){
	// 		for(int sn = ssn; sn < ssn + SN; sn+=NN){	
	// 		for(int sd = ssd; sd < ssd + GSD; sd+=GDD){
	// 		for(int sh = ssh; sh < ssh + SH; sh+=HH){
	// 		for(int se = sse; se < sse + SE; se+=EE){				
				
	// 			//Value Sparsity
				
				

	// 			// total+=1 ;
	// 			// if( Xtest[bb + SB*(mm + SG*ee)] == 0 | Wtest[nn + SN*(mm + SG*ee)] == 0 ){
					
	// 			// }else{
	// 			// 	GenKQVgrouped[gidx][eidx] = 1;
	// 			// }			
					
	// 			//Physical Tile
	// 			for(int bb = 0; bb < sd + BB; bb+=B){
	// 			for(int nn = 0; nn < sd + NN; nn+=N){	
	// 			for(int dd = 0; dd < sd + GDD; dd+=GD){
	// 			for(int hh = 0; hh < sd + HH; hh+=H){
	// 			for(int ee = 0; ee < se + EE; ee+=E){				
					
					
					 
		
	// 		}}}}} 
			
			
	// 	}}}}} 
		
	// 		// if(Xtest[bb + SSB*(mm + SSN*ee)] == 0 | Wtest[bb + SSD*(mm + SSH*ee)] == 0 ){
				
	// 		// }else{
	// 		// 	GenKQVValid += 1;
	// 		// }
					
	// 	}}}}} 	
		
	// 	cout << "dense_values\t" << dense_values << endl;
	// 	cout << "dense_groups\t" << dense_groups << endl;
		
	// 	cout << "sparse_groups\t" << sparse_groups << endl;
	// 	cout << "sparse_groups_dense_values\t" << sparse_groups_dense_values << endl;
	// 	// cout << dense_groups/sparse_groups << endl;
		
	// 	// cout << dense_groups/sparse_groups << endl;
	// 	if(sparse_groups == 0){
	// 		sparse_groups = dense_groups;
	// 	}
		
	// 	if(sparse_groups_dense_values == 0){
	// 		sparse_groups_dense_values = dense_values;
	// 	}
	// 	cout << "group speedup\t" << dense_groups/sparse_groups <<endl;
	// 	cout << "group dense value speedup\t" << dense_values/sparse_groups_dense_values<<endl;
	// 	// cout << "total\t" << total<<endl;
	// 	// cout << "Xsp\t" << Xsp << endl;
	// 	// cout << "Wsp\t" << Wsp << endl;
	// 	// cout <<"GenKQVvalid\t" << (float) GenKQVValid/total<<endl;
	// 	// // cout <<"ScoreValid" << (float) ScoreValid/total<<endl;
	// 	// cout <<"OutValid" << (float) OutValid/total<<endl;
		
	// 	//Results
	// 	float KVQGenGroupSpeedup = (float) dense_values/sparse_groups_dense_values;
	// 	float KVQGenValueSpeedup = (float) dense_case/grouped_sparse_cycles_max;
		
	// 	cout << "KVQGenGroupSpeedup\t"  <<  KVQGenGroupSpeedup << endl;
	// 	cout << "KVQGenValueSpeedup\t" <<   KVQGenValueSpeedup << endl;
		
		cout << "KVQGenGroupSpeedup\t"  <<  KVQGenGroupSpeedup << endl;
		cout << "KVQGenValueSpeedup\t" <<   KVQGenValueSpeedup << endl;
		
						
	
	
	
	// return 0;
		
		// if(PhiX & PhiW){
		// 	valgroup = BB/B * NN/N * DD/D * HH/H ;
		// 	//Inputs: SB*SN*SD*SH / (valgroup);
		// 	//Input to each group
		// 	//
		
		
		// }else if(PhiX ){
		// 	valgroup = BB/B * NN/N;
		// 	for(int bb = 0; bb < BB; bb += B){
		// 	for(int nn = 0; nn < NN; nn += N){
				
		// 		for(int sb = 0; sb < SB; sb += BB){
		// 		for(int sn = 0; sn < SN; sn += NN){
		// 		for(int se = )
					
		// 			int se = 0; int sh = 0; sd = 0;
		// 			if(valuemask[se + GSSD*(sh + SSH*(sd +  GSD*(sn  + SN*sb)) ]){
						
		// 			}else{
		// 				sp_cycles_value[spidx] += 1; 
		// 			}
		// 		}}
		// 		 cout << sp_cycles_value[spidx]  << endl;
				 
		// 		// sp_cycles_value[spidx] = 
		// 		spidx += 1;
				
				
		// 	}}
		// }else if (PhiW){
		// 	valgroup = DD/D * EE/E * HH/H ;
		// }
		
	// 	return 0;
		
	// 	for(int sb = 0; sb < 0 + SB; sb+=BB){
	// 	for(int sn = 0; sn < 0 + SN; sn+=NN){	
	// 	for(int sd = 0; sd < 0 + GSD; sd+=GDD){
	// 	for(int sh = 0; sh < 0 + SH; sh+=HH){
	// 	for(int se = 0; se < 0 + SE; se+=EE){							
	
	// 		dense_cycles_value += 1;
			
	// 		// cout << "go"<<endl;
	// 		if(PhiX & PhiW){
				
	// 		}else if(PhiX){
				
	// 		}else if(PhiW){
				
	// 		}
			
	
	// 		//Physical Tile
	// 		for(int bb = 0; bb < sb + BB; bb+=B){
	// 		for(int nn = 0; nn < sn + NN; nn+=N){	
	// 		for(int dd = 0; dd < sd + GDD; dd+=GD){
	// 		for(int hh = 0; hh < sh + HH; hh+=H){
				
	// 			for(int ee = 0; ee < se + EE; ee+=E){				
					
					
					
	// 			}
			
	// 		}}}} 
			
	// 		spidx++;
			
	// 	}}}}} 
			
	// 	cout << "total cycles per round\t" << valuesparse_max_groups<<endl;
	// 	cout << "dense_cycles_value\t" << dense_cycles_value << endl;
		// cout << "sparse_cycles_value\t" << dense_cycles_value << endl;
		// return 0;
	
		
	
		
		
			
	// 	// cout << GenKQVValid<<endl;
	// 	// cout << total<<endl;
	// 	//Need to consider hardware constraints	
	// 	// SG / SpG ;
	// 	// SB / SpB ;
	// 	// SN / SpN ;
	// 	// SI / SpI ;
	// 	int groups = SG*SB*SN;
	// 	int elt    = SI;
		
	// 	int GenKQVgrouped[groups][elt];
	// 	for(int g = 0 ; g < groups; g++){
	// 		for(int e = 0; e < elt; e++){
	// 			GenKQVgrouped[g][e] = 0;
	// 		}
	// 	}
		
	// 	for(int bb = 0; bb < SB; bb++){
	// 	for(int nn = 0; nn < SN; nn++){
	// 	for(int mm = 0; mm < SG; mm++){
	// 	for(int ee = 0; ee < SI; ee++){
			
	// 		//Emulate the data process
	// 		//Based on different groups
			
	// 		// for(int b = bb; b < bb+SB; b++){
	// 		// for(int n = nn; n < nn+SN; n++){
	// 		// for(int m = mm; m < mm+SG; m++){
			
	// 		// for(int e = ee; e < ii+SI; e++){
	// 		int gidx = mm + SG*(nn + SN*bb);
	// 		int eidx = ee;
	// 		// cout <<"xidx,Widx" << bb + SB*(mm + SG*ee)<<"\t"<<nn + SN*(mm + SG*ee) << endl;
	// 		// cout << "X,W " << Xtest[bb + SB*(mm + SG*ee)]<<"\t"<<Wtest[nn + SN*(mm + SG*ee) ] << endl;
	// 		// cout << gidx << endl;
	// 		if( Xtest[bb + SB*(mm + SG*ee)] == 0 | Wtest[nn + SN*(mm + SG*ee)] == 0 ){
				
	// 		}else{
	// 			GenKQVgrouped[gidx][eidx] = 1;
	// 		}			
			
	// 		// total+=1 ;
			
	// 	}}}}
	// 	//N: 8:8 (0, 1, 2, 3, 4, 5 6) --> 8
	// 	//N: 64:8 (0 1 2 3 4 5 6 7 8) --> Grouped together 
	// 	int super_groups =  SB/SpBB  *SG/SpGG * SN/SpNN ;
	// 	int super_elt = SI / SpI  ; // 8, 4 -> 2
	// 	int pe_groups = SpBB/SpB * SpGG/SpG * SpNN/SpN;
		
	// 	cout << "super_groups " << super_groups<<endl;
	// 	cout << "groups " << groups<<endl;
	// 	cout << "pe_groups " << pe_groups<<endl;
		
	// 	int max_cyc = 0;
		
		
	// 	cout << "SI\t" << SI << endl;
	// 	cout << "SII\t" << SpII << endl;
	// 	cout << "SN\t" << SN << endl;
	// 	cout << "SpNN\t" << SpNN << endl;
	// 	cout << "SpN\t" << SpN << endl;
	// 	cout << "SN\t" << SB << endl;
	// 	cout << "SpNN\t" << SpBB << endl;
	// 	cout << "SpN\t" << SpB << endl;
		
		
		
		
	// 	for(int gg = 0 ; gg < groups; gg += super_groups){
	// 	int gp_count = 0;
	// 	for(int g = gg ; g < gg+super_groups; g+=pe_groups){
	// 		int count = 0;
	// 		int dense_count = 0;
	// 		for(int ggg = g ; ggg < g+pe_groups; ggg++){
				
	// 			for(int e = 0; e < elt; e++){
	// 				cout << gg<<"\t"<<g <<"\t"<< ggg << "\t" << e << endl;
				
	// 				count += GenKQVgrouped[ggg][e] ;
	// 				dense_count += 1;
	// 				// cout << GenKQVgrouped[g][e]<<endl;
					
					
	// 			}
	// 		}
	// 	}
		
	// 	}
		
	// 	return 0;
		
	// 	for(int gg = 0 ; gg < groups; gg += super_groups){
			
		
	// 	int gp_count = 0;
	// 	for(int g = gg ; g < gg+super_groups; g+=pe_groups){
	// 		int count = 0;
	// 		int dense_count = 0;
	// 		for(int ggg = g ; ggg < g+pe_groups; ggg++){
				
	// 			for(int e = 0; e < elt; e++){
	// 				// cout << g << "\t" << e << endl;
				
	// 				count += GenKQVgrouped[ggg][e] ;
	// 				dense_count += 1;
	// 			// 	cout << GenKQVgrouped[g][e]<<endl;
					
	// 			}
	// 			// cout << "\tgg\t" << gg << "\tg\t" << g << endl;
	// 		}
			
	// 		// cout << "g\t" << g<<"\t"<< count<<"\ttotal\t" << elt <<"\t;";
			
	// 		cout << "dense\t" << dense_count<<"\tsparse\t"<< count <<"\t;";
			
	// 		// if(count == 0){
	// 		// 		cout << elt << "\t" << 1 << endl;
	// 		// }else{
	// 		// 			cout << elt << "\t" << (count+super_elt-1)/super_elt << endl;
	// 		// }
	// 		int grp_cycles = (count+dense_count-1)/dense_count;
	// 		cout << "group_cycles " << grp_cycles << endl;
	// 		if(max_cyc < grp_cycles){
	// 			max_cyc = grp_cycles;
	// 		}
	// 		// cout << total << "\t" << total/count << endl;
	// 	}
		
	// 		cout << endl;
	// 	}
		
	// 	float pes = SpBB * SpGG * SpNN;
		
	// 	cout << "cycles per block" << max_cyc;
	// 	cout << "dense cycles " << super_elt;
	// 	cout << "scaled by size" << max_cyc/pes<<endl;
		
	
	
	
	
	
	
	
	return 0;
 
	////////////////////////////////////////////
	
// 	cout << "prefill_mha_fused" << endl;
// 	//A transformer / QWen1 layer (prefill)
// 	int dModel = 32;
// 	int numHeads = 2;
// 	int Batch = 1;
// 	int Seq = 2;
	
// 	// dModel = 1024;
// 	// numHeads = 16;
// 	// Batch = 4;
// 	// Seq = SEQ;//SEQ=1024
	
// 	// //L1 - 16x8 = 128kb
// 	// int cache = CACHE;
	
	
// 	dModel = DMODEL; //1024
// 	numHeads = HEADS; //16
// 	Batch = BATCH;//4
// 	Seq = SEQ;//SEQ=1024
	
// 	//L1 - 16x8 = 128kb
// 	int cache = CACHE;
	
	
	
// 	//MM
// 	int Kcache  = cache;
// 	int Vcache  = cache;
// 	int Qcache  = cache;
// 	int PScache = cache; 	   
// 	int Xcache  = cache;                           
// 	int Wkcache = cache;                            
// 	int Wvcache = cache;                           
// 	int Wqcache = cache;
		
	
// 	//Softmax
// 	int Scache = cache;
	
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
		
// 	#if(TILE1)
// 	SH = 16;SN = 64;SB = 4;SM = 1;SO = 1;SD = 1;// SO = 64;
// 	SNN = 128; SMM = 128; SDD = 128; SOO = 128;
// 	#endif
	
// 	#if(TILE2)
// 	SH = 1;SN = 64;SB = 1;SM = 1;SO = 64;SD = 64;// SO = 64;
// 	SNN = 128; SMM = 128; SDD = 128; SOO = 128;
// 	#endif	

// 	#if(TILE3)
// 	SH = 1;SN = 8;SB = 1;SM = 8;SO = 64;SD = 64;// SO = 64;
// 	SNN = 64; SMM = 128; SDD = 128; SOO = 128;
// 	#endif	

// 	#if(TILE4)
// 	SH = 16;SN = 1;SB = 4;SM = 64;SO = 1;SD = 64;// SO = 64;
// 	SNN = 64; SMM = 64; SDD = 64; SOO = 64;
// 	#endif	
		
// 		// int TILING = 512;
// 		SNN = TILING; SMM = TILING; SDD = TILING; SOO = TILING;
		
// 	//matrix multiply
// 	int MM_SG = 1; 
// 	int MM_SB = 1;
// 	int MM_SN = 64;
// 	int MM_SI = 64;
	
// 	int MM_SBB = 512;
// 	int MM_SGG = 512;
// 	int MM_SNN = 512;
	
// 	//softmax
// 	int SM_SB = SB;
// 	int SM_SN = SN;
// 	int SM_SM = SM;
	
// 	int SM_SNN = 64;
// 	int SM_SMM = 64;
// 	////////////////////////////////////////
	
	
// 	float scale = 1e9/1e12;
// 	float TFLOP_MM1  =scale* SM*SB*SN*SD*SH;   
// 	float TFLOP_SM   =scale* SM_SB*SM_SN*SM_SM;   
// 	float TFLOP_MM2  =scale* SM*SB*SN*SO*SH;   
	
// 	float TFLOP_MEGAM =scale* (SM*SB*SN*SH)*(SD+SO);

// 	cout << "TFLOPS " << TFLOP_MM1+TFLOP_SM+TFLOP_MM2 << endl;	
// 	cout << "TFLOPS(MULT)" << TFLOP_MEGAM<<endl;
// 	// return 0;
		
// 	////////////////////////////////////////////////////////////////////////////
// 	//Simulation
// 	unsigned long long cycles = 0;
// 	unsigned long long actual_cycles = 0;
// 	unsigned long long xreuse = 0;
// 	unsigned long long wkreuse = 0;
// 	unsigned long long wqreuse = 0;
// 	unsigned long long kreuse = 0;
// 	unsigned long long qreuse = 0;
	
// 	//In sequence
// 	//K generation
	
// 	// SMM = MM_SBB;
// 	// SDD = MM_SNN;
// 	// Wkcache =Wcache; 
// 	for(int mmm = 0; mmm < DimM; mmm += SMM){
// 	for(int ddd = 0; ddd < DimD; ddd += SDD){

// 		#if(OS | KS)        //[B,H,M]                             
// 			for(int b = 0; b < DimB; b += SB ){
// 			for(int h = 0; h < DimH; h +=   SH  ){	
// 			for(int m = 0; m+mmm < std::min(DimM,mmm+SMM) ; m +=   SM ){
				
// 			for(int d = 0; d+ddd < std::min(DimD,ddd+SDD) ; d +=  ( SD+SO) ){
// 			for(int e = 0; e < DimE; e +=    SN ){
// 					int X_reuse = (DimE <= Xcache & d > 0) | (DimE*SMM <= Xcache & h > 0) |
// 						(DimB*DimE*SMM <= Xcache & ddd > 0) ;				
// 					int Wk_reuse = (DimE*SDD <= Wkcache & m > 0) | 
// 						(DimE*SDD*DimH <= Wkcache & b > 0) |(DimE*DimD*DimH <= Wkcache & mmm > 0) ;					
// 		#endif
// 		#if(WS)             // [H,D,E]
// 			for(int h = 0; h < DimH; h +=   SH  ){
// 			for(int d = 0; d+ddd < std::min(DimD,ddd+SDD) ; d +=   ( SD+SO) ){
// 			for(int e = 0; e < DimE; e +=    SN ){
			
// 			for(int b = 0; b < DimB; b += SB ){
// 			for(int m = 0; m+mmm < std::min(DimM,mmm+SMM) ; m +=   SM ){
// 				int X_reuse = (DimE*SMM*DimB <= Xcache & d > 0) | (DimE*SMM*DimB <= Xcache & h > 0) |
// 					(DimB*DimE*SMM <= Xcache & ddd > 0) ;				
// 				int Wk_reuse = (1 <= Wkcache & m > 0) | 
// 					(1 <= Wkcache & b > 0) |(DimE*DimD*DimH <= Wkcache & mmm > 0) ;					
// 		#endif
// 		#if(XS)           // [B,M,E]           
// 			for(int e = 0; e < DimE; e +=    SN ){
				
// 					for(int b = 0; b < DimB; b += SB ){
// 				for(int m = 0; m+mmm < std::min(DimM,mmm+SMM) ; m +=   SM ){
			
// 			for(int h = 0; h < DimH; h +=   SH  ){	
// 			for(int d = 0; d+ddd < std::min(DimD,ddd+SDD) ; d +=   (SD+SO) ){
// 					int X_reuse = (1 <= Xcache & d > 0) | (1 <= Xcache & h > 0) |
// 						(DimB*DimE*SMM <= Xcache & ddd > 0) ;				
// 					int Wk_reuse = (DimH*SDD <= Wkcache & m > 0) | 
// 						(SDD*DimH <= Wkcache & b > 0) |(DimE*DimD*DimH <= Wkcache & mmm > 0) ;					
// 		#endif
		
// 			cycles += MULT_cyc;
			
			
			
// 			int cycle_round = 0;
// 			int reuse_round = SRAM_read_cyc;
// 			int round = 0;
		
// 			if(xreuse){
// 			}else{
// 				cycle_round +=	DRAM_read_cyc;
// 			}
// 			if(wkreuse){
// 			}else{
// 				cycle_round +=	DRAM_read_cyc;
// 			}		
// 			round = max(reuse_round, cycle_round);;
			
// 			actual_cycles += round;
						
			
// 		}}}}}
// 	}}
	
// 	// cout << "extra " << ((DimB*DimM*DimD*DimH)/SG/1/SB/SN)*DRAM_read_cyc +((DimB*DimM*DimD*DimH)/SG/1/SB/SN)* DRAM_read_cyc<<endl;
// 	actual_cycles *= 3;
// 	// actual_cycles += ((DimB*DimM*DimD*DimH)/SM/SH/SB/(SO+SD))*DRAM_read_cyc*3 +((DimB*DimM*DimD*DimH)/SM/SH/SB/(SO+SD))* DRAM_read_cyc;
	
// 	cout << "KQVGen " << actual_cycles/1e9  <<endl;
	
	
	
// 	//Score - Softmax - Output (FUSED)
// 	for(int nnn = 0; nnn < DimN; nnn += SNN){
// 	for(int mmm = 0; mmm < DimM; mmm += SMM){
// 	for(int ddd = 0; ddd < DimD; ddd += SDD){
// 	for(int ooo = 0; ooo < DimD; ooo += SOO){


// 	//K: [B,M,H,D] n o
// 	//V: [B,M,H,O] n d
// 	//Q: [B,N,H,D] m o
// 	#if(OS)                                 
// 		for(int b = 0; b < DimB; b += SB){
// 		for(int h = 0; h < DimH; h += SH){	
// 		for(int n = 0; n+nnn < std::min(DimN, nnn+SNN); n += SN){	
// 		for(int o = 0; o+ooo < std::min(DimD, ooo+SOO); o += SO){
		
// 		for(int m = 0; m+mmm < std::min(DimM,mmm+SMM); m += SM){
// 		for(int d = 0; d+ddd < std::min(DimD,ddd+SDD); d += SD){

// 				int K_reuse = (SDD*SMM <= Kcache & n > 0) |
// 					(DimD*DimH*DimB*SMM <= Kcache & nnn > 0) |
					
// 					(SDD*SMM <= Kcache & o > 0) |
// 					(DimD*DimH*DimB*SMM <= Kcache & ooo > 0) ;
				
// 				int V_reuse = (SDD*SMM <= Vcache & n > 0) |
// 					(SOO*DimH*DimB*SMM <= Vcache & nnn > 0) |
					
// 					(1 <= Vcache & d > 0) |
// 					(SOO*DimH*DimB*SMM <= Vcache & ddd > 0) ;
				
// 				int Q_reuse = (SDD <= Qcache & m > 0) |
// 					(SDD*DimH*DimB*SMM <= Qcache & mmm > 0) |
					
// 					(SDD*SMM <= Qcache & o > 0) |
// 					(SDD*DimH*DimB*SMM <= Qcache & ooo > 0) ;
					
// 				int P_reuse = (1 <= PScache & d > 0) |
// 					(DimH*DimB*SNN*SMM <= PScache & ddd > 0) |
					
// 					(SMM <= PScache & o > 0) |
// 					(DimH*DimB*SMM*SNN <= PScache & ooo > 0) ;				
// 	#endif


// 	//K: [B,M,H,D] n o
// 	//V: [B,M,H,O] n d
// 	//Q: [B,N,H,D] m o
// 	//P: [B,M,N,H] d o
// 	#if(WS | XS | KS)	
// 		//Key stationary 
// 		for(int b = 0; b < DimB; b += SB){
// 		for(int h = 0; h < DimH; h += SH){				
// 		for(int m = 0; m+mmm < std::min(DimM,mmm+SMM); m += SM){
// 		for(int d = 0; d+ddd < std::min(DimD,ddd+SDD); d += SD){
				
// 		for(int n = 0; n+nnn < std::min(DimN, nnn+SNN); n += SN){	
// 		for(int o = 0; o+ooo < std::min(DimD, ooo+SOO); o += SO){

		
// 			int K_reuse = (1 <= Kcache & n > 0) |
// 				(SDD*DimH*DimB*SMM <= Kcache & ooo > 0) |
// 				(1 <= Kcache & o > 0) |
// 				(DimD*DimH*DimB*DimM <= Kcache & nnn > 0) ;
			
			
// 			int V_reuse = (SOO <= Vcache & n > 0) |
// 				(SOO*DimH*DimB*SMM <= Vcache & nnn > 0) |
// 				(SOO <= Vcache & d > 0) |
// 				(SOO*DimH*DimB*SMM <= Vcache & ddd > 0) ;
			
			
// 			int Q_reuse = (SDD*SNN <= Qcache & m > 0) |
// 				(SDD*DimH*DimB*SNN <= Qcache & mmm > 0) |
				
// 				(1 <= Qcache & o > 0) |
// 				(SDD*DimH*DimB*SNN <= Qcache & ooo > 0) ;

// 			int P_reuse = (SNN <= PScache & d > 0) |
// 				(DimH*DimB*SNN*SMM <= PScache & ddd > 0) |
				
// 				(1 <= PScache & o > 0) |
// 				(DimH*DimB*SMM*SNN <= PScache & ooo > 0) ;

// 	#endif						
				
// 	#if(QS)	
// 		//Query stationary 
// 		for(int b = 0; b < DimB; b += SB){	
// 		for(int n = 0; n+nnn < std::min(DimN,nnn+SNN); n += SN){
// 		for(int h = 0; h < DimH; h += SH){
// 		for(int d = 0; d+ddd < std::min(DimD,ddd+SDD); d += SD){
// 		for(int m = 0; m+mmm < std::min(DimM,mmm+SMM); m += SM){
// 		for(int e = 0; e < DimE; e += SE){

// 	#endif
// 				int cycle_round = 0;
// 				int reuse_round = SRAM_read_cyc;
// 				int round = 0;
				
// 				if(P_reuse & V_reuse){
// 					if(d+SD>=DimD){
// 						if(m+SM>=DimM){
// 							round = max(reuse_round, cycle_round);;
// 						}
// 					}					
// 				}else if(P_reuse){	
// 					if(d+SD>=DimD){
// 					if(V_reuse){
// 					}else{
// 						cycle_round +=	DRAM_read_cyc;
// 					}
					
// 					round = max(reuse_round, cycle_round);;
// 					}
// 				}else if(V_reuse){
// 					if(K_reuse){
// 					}else{
// 						cycle_round +=	DRAM_read_cyc;
// 					}
// 					if(Q_reuse){
// 					}else{
// 						cycle_round +=	DRAM_read_cyc;
// 					}	
// 					round = max(reuse_round, cycle_round);;
// 				}else{
// 					if(K_reuse){
// 					}else{
// 						cycle_round +=	DRAM_read_cyc;
// 					}
// 					if(Q_reuse){
// 					}else{
// 						cycle_round +=	DRAM_read_cyc;
// 					}
// 					if(V_reuse){
// 					}else{
// 						cycle_round +=	DRAM_read_cyc;
// 					}
// 					round = max(reuse_round, cycle_round);;
// 				}
				
// 				actual_cycles += round;
				

// 		}}}}}}
		
// 		}}}	}
// actual_cycles += ((DimB*DimN*DimD*DimH)/SO/SH/SB/SN)* DRAM_read_cyc;
// 	cout << "Fused Out " << actual_cycles/1e9  <<endl;		

 	// return 0;
  }




int main(){
	
	#if(MHABASE)
	prefill_mha_baseline()
	;
	cout<<endl;
	#endif
	
	
	#if(MHAFUSE)
	prefill_mha_fused();
	cout<<endl;
	#endif
	
}