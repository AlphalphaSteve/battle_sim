--base apollo variable to export
local apollo = {}

--make differect catagories of apollo, apollo.physics, graphics, etc
apollo.physics = {}
apollo.physics.map = {}
apollo.graphics = {}
apollo.sprite = {}
apollo.sprite.animation = {}

--all apollo.physics based functions
function apollo.physics.collideCheck(obj1, obj2)
	if
		obj1.x < obj2.x + obj2.w
		and obj2.x < obj1.x + obj1.w
		and obj1.y < obj2.y + obj2.h
		and obj2.y < obj1.y + obj1.h
	then
		return true
	else
		return false
	end
end

function apollo.physics.collideCheckDir(obj1, obj2)
	-- No collision
	if
		not (
			obj1.x < obj2.x + obj2.w
			and obj1.x + obj1.w > obj2.x
			and obj1.y < obj2.y + obj2.h
			and obj1.y + obj1.h > obj2.y
		)
	then
		return nil
	end

	local obj1Bottom = obj1.y + obj1.h
	local obj2Bottom = obj2.y + obj2.h
	local obj1Right = obj1.x + obj1.w
	local obj2Right = obj2.x + obj2.w

	local bottomCollision = obj2Bottom - obj1.y
	local topCollision = obj1Bottom - obj2.y
	local leftCollision = obj1Right - obj2.x
	local rightCollision = obj2Right - obj1.x

	if topCollision < bottomCollision and topCollision < leftCollision and topCollision < rightCollision then
		return "top"
	elseif bottomCollision < topCollision and bottomCollision < leftCollision and bottomCollision < rightCollision then
		return "bottom"
	elseif leftCollision < rightCollision and leftCollision < topCollision and leftCollision < bottomCollision then
		return "left"
	elseif rightCollision < leftCollision and rightCollision < topCollision and rightCollision < bottomCollision then
		return "right"
	end

	return nil
end

function apollo.physics.getHitbox(object)
	local hb = object.hitbox

	return {
		x = object.x + hb.x,
		y = object.y + hb.y,
		w = hb.w,
		h = hb.h,
	}
end

function apollo.physics.collisionBox(x1, y1, w1, h1, x2, y2, w2, h2)
	if x1 < x2 + w2 and x2 < x1 + w1 and y1 < y2 + h2 and y2 < y1 + h1 then
		return true
	else
		return false
	end
end

function apollo.physics.newWorld(hGrav, vGrav, gravEnable)
	local world = love.physics.newWorld(hGrav, vGrav, gravEnable)
	return world
end

function apollo.physics.newBody(world, x, y, w, h, mode)
	local object = {}
	object.body = love.physics.newBody(world, x, y, mode)
	object.shape = love.physics.newRectangleShape(w, h)
	object.fixture = love.physics.newFixture(object.body, object.shape)
	object.fixture:setFriction(0)
	object.fixture:setRestitution(0)
	return object
end

--all apollo.animation based functions
function apollo.sprite.new(img, x, y, w, h, sx, sy, rot)
	if rot == nil then
		rot = 1
	end
	local sprite = {
		osx = sx * w,
		osy = sy * h,
		sx = sx * w,
		sy = sy * h,
		x = x,
		y = y,
		w = w,
		h = h,
		img = img,
		msx = 0,
		currentAnimation = nil,
		rot = rot,
	}
	sprite.hitbox = {
		x = 0,
		y = 0,
		w = sprite.w,
		h = sprite.h,
	}
	sprite.quad =
		love.graphics.newQuad(sprite.sx, sprite.sy, sprite.w, sprite.h, sprite.img:getWidth(), sprite.img:getHeight())
	sprite.timer = 0
	sprite.animTime = 0
	sprite.animations = {}
	sprite.x = x
	sprite.y = y
	return sprite
end

function apollo.sprite.animationSet(animation, sprite)
	if sprite.currentAnimation == animation then
		return
	end
	sprite.currentAnimation = animation
	sprite.sx = animation.osx
	sprite.sy = animation.osy
	sprite.osx = animation.osx
	sprite.osy = animation.osy
	sprite.msx = animation.msx
	sprite.img = animation.img
	sprite.w = animation.w
	sprite.h = animation.h
	sprite.animTime = animation.animTime
	sprite.timer = 0
	sprite.quad:setViewport(sprite.sx, sprite.sy, sprite.w, sprite.h, sprite.img:getWidth(), sprite.img:getHeight())
end

function apollo.sprite.animation.new(osx, osy, msx, img, w, h, animTime)
	local animation = {}
	animation.osx = osx * w
	animation.osy = osy * h
	animation.msx = msx * w
	animation.img = img
	animation.w = w
	animation.h = h
	animation.animTime = animTime
	return animation
end

function apollo.sprite.animate(sprite, dt)
	if sprite.animTime <= 0 then
		return
	end
	sprite.timer = sprite.timer + dt
	if sprite.timer >= sprite.animTime then
		sprite.timer = 0
		sprite.sx = sprite.sx + sprite.w
		if sprite.sx > sprite.msx then
			sprite.sx = sprite.osx
		end
		sprite.quad:setViewport(sprite.sx, sprite.sy, sprite.w, sprite.h, sprite.img:getWidth(), sprite.img:getHeight())
	end
end

function apollo.sprite.draw(sprite)
	if sprite.rot == -1 then
		love.graphics.draw(sprite.img, sprite.quad, sprite.x + sprite.w, sprite.y, 0, sprite.rot, 1)
	else
		love.graphics.draw(sprite.img, sprite.quad, sprite.x, sprite.y, 0, sprite.rot, 1)
	end
end

--returning apollo variable
return apollo
