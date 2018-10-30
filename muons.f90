program muons
  implicit none
  integer :: k, m, day, number
  integer, parameter :: N = 1000000 ! number of data sets
  integer, dimension(N,0:100) :: histories
  integer, dimension(0:100) :: maxEvents, sumEvents
  double precision :: prob, x, numMuons, totMuons
  double precision, dimension(0:100) :: p
  double precision, parameter  :: an = 0.1d0 ! <n> of events per day
  p(0) = exp(-an); prob = p(0); maxEvents = 0
  ! p(k) is the probability of less than k+1 events per day
  do k = 1, 100
     prob = prob + an**k*exp(-an)/gamma(real(k+1,8))
     p(k) = prob
  end do
  call random_seed() ! random initialization
  do k = 1, N ! do 10,000 histories
     do day = 1, 100 ! do day of kth history
        call random_number(x)
        do m = 100, 0, -1
           if (x < p(m)) then
              number = m
           end if
        end do
        histories(k,day) = number
     end do
     numMuons = maxval(histories(k,:)); totMuons = sum(histories(k,:))
     maxEvents(numMuons) = maxEvents(numMuons) + 1
     sumEvents(totMuons) = sumEvents(totMuons) + 1
  end do
  open(7,file="maxEvents"); open(8,file="totEvents")
  do k = 0, 100
     write(6,*) k, maxEvents(k), 100*maxEvents(k)/real(N), '%' &
          , sumEvents(k), 100*sumEvents(k)/real(N), '%'
     write(7,*) k, maxEvents(k)
     write(8,*) k, sumEvents(k) 
  end do
  close(7); close(8)
end program muons
