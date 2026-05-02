import os, argparse 

toppath = os.path.abspath(os.getcwd())
pgm = "bison"
srcpath = toppath + f"/{pgm}-3.8"
binpath = srcpath + "/src"
def build_gcov():
    # download the benchmark 
    os.system("wget https://ftp.gnu.org/gnu/bison/bison-3.8.tar.xz")
    os.system("tar -xf bison-3.8.tar.xz")
    os.chdir(srcpath)
    os.system('./configure --disable-nls CC=/usr/bin/gcc CXX=/usr/bin/g++ GCOV=/usr/bin/gcov CFLAGS="-g -O2 -fprofile-arcs -ftest-coverage -fprofile-abs-path" CXXFLAGS="-g -O2 -fprofile-arcs -ftest-coverage -fprofile-abs-path" LDFLAGS="--coverage"')
    os.system("make -j$(nproc)")
    if os.path.exists(f"{binpath}/bison"):
        print("Build Complete")
    else:
        print("Build Error")
    
def run_testcase(file_name):
    with open(file_name, 'r') as f:
        testcases=[l.split('\n')[0] for l in f.readlines()]
    
    os.system("find " + srcpath + ' -name "*.gcda" -exec rm {} \;')
    os.system("find " + srcpath + ' -name "*.gcov" -exec rm {} \;')
    
    os.chdir(binpath)
    print("----------------Run Test-Cases-------------------------------------")
    print("-------------------------------------------------------------------")
    for tc in testcases:
        os.system(tc)
    gcov_file="cov_result"
    os.system("find " + srcpath + ' -name "*.gcda" -exec gcov -bc {} 1>'+gcov_file+' 2> err \;')
    os.system("find " + srcpath + ' -name "*.gcda" -exec rm {} \;')
    os.system("find " + srcpath + ' -name "*.gcov" -exec rm {} \;')
    return cal_coverage(gcov_file)

def cal_coverage(cov_file):
    coverage=0
    total_coverage=0
    with open(cov_file, 'r') as f:
        lines= f.readlines()
        for line in lines:
            if "Taken at least" in line:
                data=line.split(':')[1]
                percent=float(data.split('% of ')[0])
                total_branches=float((data.split('% of ')[1]).strip())
                covered_branches=int(percent*total_branches/100)
                
                coverage=coverage + covered_branches    
                total_coverage=total_coverage + total_branches 
    print("----------------Results--------------------------------------------")
    print("The number of covered branches: " + str(coverage))
    print("The number of total branches: " + str(int(total_coverage)))
    print("-------------------------------------------------------------------")
    return coverage

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('--build', action='store_true')
    parser.add_argument("--testcase_file",dest='testcase_file', default="test.txt")
    args = parser.parse_args()
    flag = args.build
    testcase_file = args.testcase_file
    
    if flag==True:
        build_gcov()
    else:
        if not testcase_file:
            print("No testcase")
            exit()
        cov = run_testcase(testcase_file)

if __name__ == '__main__':
    main()
