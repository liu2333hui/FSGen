

import os
	

#BASELINE 1
'''
for DECODE in ["", "-DDECODE"]:
	#Our Work
	##"WS", "OS", "KS"]:
	for LP, TILE in [
			#D1
			["WS", "TILE4",]   
				
		]:
			
		for SEQ, BATCH, HEADS, DMODEL in [
				[1024, 4, 16, 64],
				[16096, 4, 16, 64],
				[1024, 4, 32, 128],
				[19096, 4, 32, 128],
				[196, 4, 16, 64],
			]:
			compil = f"g++ ./attention_sp.cpp -DMHABASE {DECODE} -D{TILE} -D{LP} -DSEQ={SEQ} -DBATCH={BATCH} -DHEADS={HEADS} -DDMODEL={DMODEL} -DCACHE=16000 -O3 -DTILING=512"
			#print(compil)
			return_code = os.system(compil)
			os.system(".\\a.exe")
			#exit()
'''

#BASELINE 2

for DECODE in ["", "-DDECODE"]:
	#Our Work
	##"WS", "OS", "KS"]:
	for LP, \
		ZH, ZHH, ZSH, ZSSH,   ZN, ZNN, ZSN, ZSSN,         ZM, ZMM, ZSM, ZSSM,         ZB, ZBB, ZSB, ZSSB 		,  ZD, ZDD, ZSD, ZSSD			,  ZO, ZOO, ZSO, ZSSO, \
		vs, gs, ms in [
			
			#D1
			["WS", 
				1,  8,  8,   8,        1,  1,  4,   16,     		1,  4,  4,   16, 	     	  1,  4,  4,   4,            1, 2, 8,  8,               1,  8, 8,  8,
				4, 2, 4],
				
			#D2
			["WS", 
				1,  1,  1,   1,        1,  4,  8,   32,     		1,  4,  8,   32, 	     	  1,  1,  1,   1,            1, 64,  64,  64,               1,  64, 64,  64,
				1, 2, 2],
			
			#D3
			["WS", 
				1,  1,  1,   1,        1,  4,  8,   32,     		1,  4,  8,   32, 	     	  1,  1,  1,   1,            1, 64,  64,  64,               1,  64, 64,  64,
				1, 2, 4],
				
			#D4
			["WS", 
				1,  1,  1,   1,        1,  32,  64,   256,         1,1,1,4, 			     	 1,  1,  1,   1,            1, 32,  64,  64,               1,  64, 64,  64,
				1, 2, 4]
			
			
		]:
		
		
			tilings = f"-DZH={ZH} -DZN={ZN} -DZB={ZB} -DZM={ZM} -DZD={ZD} -DZO={ZO} -DZHH={ZHH} -DZSH={ZSH} -DZSSH={ZSSH}  " 					
			tilings += f"-DZNN={ZNN} -DZSN={ZSN} -DZSSN={ZSSN} -DZBB={ZBB} -DZSB={ZSB} -DZSSB={ZSSB} -DZMM={ZMM} -DZSM={ZSM} -DZSSM={ZSSM} "
			tilings += f"-DZDD={ZDD} -DZSD={ZSD} -DZSSD={ZSSD} -DZOO={ZOO} -DZSO={ZSO} -DZSSO={ZSSO} "
		
		
			
			#benchmarks
			
			
			for SEQ, BATCH, HEADS, DMODEL in [
				[1024, 4, 16, 64],
				[16096, 4, 16, 64],
				[1024, 4, 32, 128],
				[19096, 4, 32, 128],
				[196, 4, 16, 64],
			]:
			
				compil = f"g++ ./attention_sp.cpp {DECODE} -DMHAFUSE -DTILE2 -D{LP} -DSEQ={SEQ} -DBATCH={BATCH} \
					-DHEADS={HEADS} -DDMODEL={DMODEL} -DCACHE=16000 -O3 -DTILING=512 -DVS"+str(vs)+" -DGS"+str(gs)+" -DMS"+str(ms)+" "+tilings
				return_code = os.system(compil)
				os.system(".\\a.exe")





'''
 g++ .\attention.cpp -DMHABASE -DTILE2 -DOS -DSEQ=1024 -DBATCH=4 -DHEADS=16 -DDMODEL=64 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHABASE -DTILE2 -DOS -DSEQ=4096 -DBATCH=4 -DHEADS=16 -DDMODEL=64 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHABASE -DTILE2 -DOS -DSEQ=16096 -DBATCH=4 -DHEADS=16 -DDMODEL=64 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHABASE -DTILE2 -DOS -DSEQ=1024 -DBATCH=4 -DHEADS=32 -DDMODEL=128 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHABASE -DTILE2 -DOS -DSEQ=4096 -DBATCH=4 -DHEADS=32 -DDMODEL=128 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHABASE -DTILE2 -DOS -DSEQ=16096 -DBATCH=4 -DHEADS=32 -DDMODEL=128 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe


 g++ .\attention.cpp -DMHABASE -DTILE2 -DOS -DSEQ=196 -DBATCH=4 -DHEADS=16 -DDMODEL=64 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHABASE -DTILE2 -DOS -DSEQ=1024 -DBATCH=4 -DHEADS=16 -DDMODEL=64 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe







//1


 g++ .\attention.cpp -DMHAFUSE -DTILE2 -DOS -DSEQ=1024 -DBATCH=4 -DHEADS=16 -DDMODEL=64 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHAFUSE -DTILE2 -DOS -DSEQ=4096 -DBATCH=4 -DHEADS=16 -DDMODEL=64 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHAFUSE -DTILE2 -DOS -DSEQ=16096 -DBATCH=4 -DHEADS=16 -DDMODEL=64 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHAFUSE -DTILE2 -DOS -DSEQ=1024 -DBATCH=4 -DHEADS=32 -DDMODEL=128 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHAFUSE -DTILE2 -DOS -DSEQ=4096 -DBATCH=4 -DHEADS=32 -DDMODEL=128 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHAFUSE -DTILE2 -DOS -DSEQ=16096 -DBATCH=4 -DHEADS=32 -DDMODEL=128 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe


 g++ .\attention.cpp -DMHAFUSE -DTILE2 -DOS -DSEQ=196 -DBATCH=4 -DHEADS=16 -DDMODEL=64 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe


 g++ .\attention.cpp -DMHAFUSE -DTILE2 -DOS -DSEQ=196 -DBATCH=4 -DHEADS=16 -DDMODEL=64 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe


 g++ .\attention.cpp -DMHAFUSE -DTILE2 -DOS -DSEQ=1024 -DBATCH=4 -DHEADS=16 -DDMODEL=64 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe







 g++ .\attention.cpp -DMHAFUSE -DTILE2 -DWS -DSEQ=1024 -DBATCH=4 -DHEADS=16 -DDMODEL=64 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHAFUSE -DTILE2 -DWS -DSEQ=4096 -DBATCH=4 -DHEADS=16 -DDMODEL=64 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHAFUSE -DTILE2 -DWS -DSEQ=16096 -DBATCH=4 -DHEADS=16 -DDMODEL=64 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHAFUSE -DTILE2 -DWS -DSEQ=1024 -DBATCH=4 -DHEADS=32 -DDMODEL=128 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHAFUSE -DTILE2 -DWS -DSEQ=4096 -DBATCH=4 -DHEADS=32 -DDMODEL=128 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHAFUSE -DTILE2 -DWS -DSEQ=16096 -DBATCH=4 -DHEADS=32 -DDMODEL=128 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe


 g++ .\attention.cpp -DMHAFUSE -DTILE2 -DWS -DSEQ=196 -DBATCH=4 -DHEADS=16 -DDMODEL=64 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe



 g++ .\attention.cpp -DMHAFUSE -DTILE2 -DWS -DSEQ=1024 -DBATCH=4 -DHEADS=16 -DDMODEL=64 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe










 g++ .\attention.cpp -DMHAFUSE -DTILE3 -DWS -DSEQ=1024 -DBATCH=4 -DHEADS=16 -DDMODEL=64 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHAFUSE -DTILE3 -DWS -DSEQ=4096 -DBATCH=4 -DHEADS=16 -DDMODEL=64 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHAFUSE -DTILE3 -DWS -DSEQ=16096 -DBATCH=4 -DHEADS=16 -DDMODEL=64 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHAFUSE -DTILE3 -DWS -DSEQ=1024 -DBATCH=4 -DHEADS=32 -DDMODEL=128 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHAFUSE -DTILE3 -DWS -DSEQ=4096 -DBATCH=4 -DHEADS=32 -DDMODEL=128 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHAFUSE -DTILE3 -DWS -DSEQ=16096 -DBATCH=4 -DHEADS=32 -DDMODEL=128 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe


 g++ .\attention.cpp -DMHAFUSE -DTILE3 -DWS -DSEQ=196 -DBATCH=4 -DHEADS=16 -DDMODEL=64 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe









 g++ .\attention.cpp -DMHAFUSE -DTILE5 -DWS -DSEQ=1024 -DBATCH=4 -DHEADS=16 -DDMODEL=64 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHAFUSE -DTILE5 -DWS -DSEQ=4096 -DBATCH=4 -DHEADS=16 -DDMODEL=64 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHAFUSE -DTILE5 -DWS -DSEQ=16096 -DBATCH=4 -DHEADS=16 -DDMODEL=64 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHAFUSE -DTILE5 -DWS -DSEQ=1024 -DBATCH=4 -DHEADS=32 -DDMODEL=128 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHAFUSE -DTILE5 -DWS -DSEQ=4096 -DBATCH=4 -DHEADS=32 -DDMODEL=128 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHAFUSE -DTILE5 -DWS -DSEQ=16096 -DBATCH=4 -DHEADS=32 -DDMODEL=128 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe


 g++ .\attention.cpp -DMHAFUSE -DTILE5 -DWS -DSEQ=196 -DBATCH=4 -DHEADS=16 -DDMODEL=64 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe








 g++ .\attention.cpp -DMHAFUSE -DTILE5 -DKS -DSEQ=1024 -DBATCH=4 -DHEADS=16 -DDMODEL=64 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHAFUSE -DTILE5 -DKS -DSEQ=4096 -DBATCH=4 -DHEADS=16 -DDMODEL=64 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHAFUSE -DTILE5 -DKS -DSEQ=16096 -DBATCH=4 -DHEADS=16 -DDMODEL=64 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHAFUSE -DTILE5 -DKS -DSEQ=1024 -DBATCH=4 -DHEADS=32 -DDMODEL=128 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHAFUSE -DTILE5 -DKS -DSEQ=4096 -DBATCH=4 -DHEADS=32 -DDMODEL=128 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe

 g++ .\attention.cpp -DMHAFUSE -DTILE5 -DKS -DSEQ=16096 -DBATCH=4 -DHEADS=32 -DDMODEL=128 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe


 g++ .\attention.cpp -DMHAFUSE -DTILE5 -DKS -DSEQ=196 -DBATCH=4 -DHEADS=16 -DDMODEL=64 -DCACHE=16000 -O3 -DTILING=512 ; .\a.exe



'''