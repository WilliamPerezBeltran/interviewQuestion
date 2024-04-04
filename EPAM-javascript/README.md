============ preguntas javascript ============

1. ¿cual es la salida de este codigo y explique "event loop" ?

console.log(1)

setTimeout(function(){
	console.log(2)
},0);

Promise.resolve()
.then(function(){
	console.log(3)
	
})
.then(function(){
	console.log(4)
})


2. ¿ explique el concepto de Promise ?

3. ¿ explique y de un ejemplo de call, apply y bind ?

4. tenemos este codigo

	[1,2].map(x=>x*2)  => su salida sera [2,4]
	realiza una funcion customMap que haga lo mismo que map:
	[1,2].customMap(x=>x*100)  => su salida sera [100,200]

5. ¿ que son funciones generadores o generator functions ?
	yield es una generator functions

6. tenemos este codigo

	const r = await sleep(()=>"a",2000)
	console.log(r)
	imite la funcion sleep => customSleep(()=>"a",2000) 

============ preguntas react js ============
7. ¿ cual es la diferencia de useCallbakc and useMemo ?
7. ¿ cual es la diferencia de useMemo y React.Memo?
8. ¿ state management, manejo de estado explique redux  ?
9. ¿ que es Context en React js , useContext ?
10. ¿ que son los custom hooks  ?
11. realize un codigo que haga dinamico el tiempo con reacj 

		13:30:41

		