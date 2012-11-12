	subroutine calcrho(prs,t,qv,qc,i1,j1,k1,rho)
	implicit none
	integer i1,j1,k1
	real t(i1,j1,k1),qv(i1,j1,k1),prs(i1,j1,k1),qc(i1,j1,k1),rho(i1,j1,k1)

	integer i,j,k

	do k=1,k1
      	do i=1,i1-1
      	do j=1,j1-1

	  rho(i,j,k)=prs(i,j,k)/(287.04*t(i,j,k)*(1-0.61*qv(i,j,k)-qc(i,j,k)))

	enddo
      	enddo
      	enddo

      	return
      	end
