#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <time.h>
#include <math.h>
#include <iostream>
#include <fstream>
#include <iomanip>
#include <vector>
#include <valarray>

using namespace std;

// Calculates the factorial of n
double factorial(const int& n) 
{
  double f = 1;

  int i=0;
  for(i = 1; i <= n; i++) 
  {
    f *= i;
  }
  return f;
}

void muons()
{
  // Declares constants
  const int N = 1000000; // Number of data sets  
  const int LOOP_ITR = 101;
  const double AN = 0.1; // Number of events per day

  // Inits local variables
  int k=0, m=0, day=0, num=0, numMuons=0, totMuons=0;
  double prob=0,tmpProb=0,fact=0, x=0;
  double p[LOOP_ITR];

  // Init local arrays
  int maxEvents[LOOP_ITR];
  int totEvents[LOOP_ITR];
  memset (maxEvents, 0, sizeof(int) * LOOP_ITR);
  memset (totEvents, 0, sizeof(int) * LOOP_ITR);

  // Creates our 2d histories array
  vector<valarray<int> > histories(N, valarray<int>(LOOP_ITR-1));
  
  // p(k) is the probability of fewer than k+1 events per day
  p[0] = exp(-AN);
  prob = p[0];
  
  // Determines p(k) for all valid k
  for (k=1; k<LOOP_ITR; k++)
  {
    fact = factorial (k);
    tmpProb = pow(AN, k);
    prob += tmpProb * (exp(-AN) / fact);
    p[k] = prob;
  }

  // Random seed
  srand ( time(NULL) );

  // Goes through all the histories
  for (k=0; k<N; k++)
  {
    // Goes through all the days
    for (day=0; day<LOOP_ITR-1; day++)
    {
      // Generates a random number betwen 0 and 1
      x = static_cast<double>(rand()) / RAND_MAX;

      // Finds an M with p(M) < X
      for (m=100; m>=0; m--)
      {
	if (x < p[m])
	{
	  num = m;
	}
      }

      histories[k][day] = num;
    }

    // Calculates max and sum
    numMuons = histories[k].max();
    totMuons = histories[k].sum();

    // Updates our records
    maxEvents[numMuons]++;
    totEvents[totMuons]++;
  }

  // Opens a data file
  ofstream fhMaxEvents, fhSumEvents;
  fhMaxEvents.open ("maxEvents.txt");
  fhSumEvents.open ("totEvents.txt");

  // Sets precision  
  fhMaxEvents.setf(ios::fixed,ios::floatfield);
  fhMaxEvents.precision(7);
  fhSumEvents.setf(ios::fixed,ios::floatfield);
  fhSumEvents.precision(7);

  // Writes the data to a file
  for (k=0; k<LOOP_ITR; k++)
  {
    fhMaxEvents << k << "   " << maxEvents[k] << endl;
    fhSumEvents << k << "   " << totEvents[k] << endl;
  }
}

int main()
{
  muons();

  return 0;
}
