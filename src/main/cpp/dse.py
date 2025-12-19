import os




# 执行g++编译命令
# for ZH, ZHH, ZSH, ZSSH in [(1, 8, 8, 8), (1, 8, 8, 8),  ]:
# 	for ZH, ZHH, ZSH, ZSSH in [(),  ]:
# 		for ZH, ZHH, ZSH, ZSSH in [(),  ]:
# 			for ZH, ZHH, ZSH, ZSSH in [(),  ]:
# 				for ZH, ZHH, ZSH, ZSSH in [(),  ]:
# 					for ZH, ZHH, ZSH, ZSSH in [(),  ]:


'''
for LP in ["WS", "OS", "XS"]:
	for TILE in ["TILE1", "TILE2", "TILE3", "TILE4"]:
		compil = f"g++ ./attention_sp.cpp -DMHASTELLAR -D{TILE} -D{LP} -DSEQ=1024 -DBATCH=4 -DHEADS=32 -DDMODEL=128 -DCACHE=16000 -O3 -DTILING=256"
		return_code = os.system(compil)
		os.system(".\\a.exe")
					
										
import sys
sys.exit()
'''


for LP in ["WS", "OS", "XS"]:
	for SCALE in [0.25, 0.5, 1, 2, 4]:
		for TILE in ["TILE1", "TILE2", "TILE3", "TILE4"]:
			compil = f"g++ ./attention_sp.cpp -DSCALE={SCALE} -DMHABASE -D{TILE} -D{LP} -DSEQ=1024 -DBATCH=4 -DHEADS=32 -DDMODEL=128 -DCACHE=16000 -O3 -DTILING=256"
			return_code = os.system(compil)
			os.system(".\\a.exe")
						
										
import sys
sys.exit()

for LP in ["WS", "OS", "KS"]:
	for ZH, ZHH, ZSH, ZSSH,   ZN, ZNN, ZSN, ZSSN,         ZM, ZMM, ZSM, ZSSM,         ZB, ZBB, ZSB, ZSSB 		,  ZD, ZDD, ZSD, ZSSD			,  ZO, ZOO, ZSO, ZSSO in [
		[1,  1,  1,   1,        1,  64,  64,   256,         1,1,1,4, 			     	 1,  1,  1,   1,            1, 64,  64,  64,               1,  64, 64,  64],
		[1,  1,  1,   1,        1,  32,  64,   256,         1,1,1,4, 			     	 1,  1,  1,   1,            1, 32,  64,  64,               1,  64, 64,  64],
				
		[1,  1,  1,   1,        1,  8,  8,   32,     		1,  8,  8,   32, 	     	  1,  1,  1,   1,            1, 64,  64,  64,               1,  64, 64,  64],
		[1,  1,  1,   1,        1,  4,  8,   32,     		1,  4,  8,   32, 	     	  1,  1,  1,   1,            1, 64,  64,  64,               1,  64, 64,  64],
		
		[1,  8,  8,   8,        1,  4,  4,   16,     		1,  4,  4,   16, 	     	  1,  4,  4,   4,            1, 8, 8,  8,               1,  8, 8,  8],
		[1,  8,  8,   8,        1,  1,  4,   16,     		1,  4,  4,   16, 	     	  1,  4,  4,   4,            1, 2, 8,  8,               1,  8, 8,  8],
								
		[1,  1,  1,   1,        1,  8,  8,   32,         	1,8,8,32, 			     	 1,  1,  1,   1,            1, 16,  16,  16,               1, 16,  16,  16],
		[1,  1,  1,   1,        1,  2,  8,   32,         	1,2,8,32, 			     	 1,  1,  1,   1,            1, 16,  16,  16,               1, 16,  16,  16],								
	]:
		tilings = f"-DZH={ZH} -DZN={ZN} -DZB={ZB} -DZM={ZM} -DZD={ZD} -DZO={ZO} -DZHH={ZHH} -DZSH={ZSH} -DZSSH={ZSSH}  " 					
		tilings += f"-DZNN={ZNN} -DZSN={ZSN} -DZSSN={ZSSN} -DZBB={ZBB} -DZSB={ZSB} -DZSSB={ZSSB} -DZMM={ZMM} -DZSM={ZSM} -DZSSM={ZSSM} "
		tilings += f"-DZDD={ZDD} -DZSD={ZSD} -DZSSD={ZSSD} -DZOO={ZOO} -DZSO={ZSO} -DZSSO={ZSSO} "
		for vs in range(1,5):
			for gs in range(1, 3):
				for ms in range(1, 5):
					compil = f"g++ ./attention_sp.cpp -DMHAFUSE -DTILE2 -D{LP} -DSEQ=1024 -DBATCH=4 -DHEADS=32 -DDMODEL=128 -DCACHE=16000 -O3 -DTILING=256 -DVS"+str(vs)+" -DGS"+str(gs)+" -DMS"+str(ms)+" "+tilings
					#print(compil)
					return_code = os.system(compil)
					os.system(".\\a.exe")
					
					
					