program integrate
  integer :: k, N
  integer, parameter :: dp = kind(1.0d0)
  real(dp) :: x, y, sum = 0.0d0, f
  real(dp),dimension(2) :: rdn
  real(dp), parameter :: area = atan(1.0d0) ! pi/4
  f(x,y) = exp(-2*x - 3*y)/sqrt(x**2 + y**2 + 1.0d0) 
  write(6,*) 'How many points?'
  read(5,*) N
  call init_random_seed() ! set new seed
  do k = 1, N
10   call random_number(rdn); x= rdn(1); y = rdn(2)
     if (x**2+y**2 > 1.0d0) then
        go to 10
     end if
     sum = sum + f(x,y)
  end do
  sum = area*sum/real(N,dp)
  write(6,*) 'The integral is ',sum
end program integrate
subroutine init_random_seed()
  implicit none
  integer i, n, clock
  integer, dimension(:), allocatable :: seed
  call random_seed(size = n) ! find size of seed
  allocate(seed(n))
  call system_clock(count=clock) ! get time of processor clock
  seed = clock + 37 * (/ (i-1, i=1, n) /) ! make seed
  call random_seed(put=seed) ! set seed
  deallocate(seed)
end subroutine init_random_seed

