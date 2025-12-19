const express=require('express');
const router=express.Router();
const jobsController=require('../controllers/jobsController');
const asyncHandler=require('../middlewares/asyncHandler');

router.get('/', asyncHandler(jobsController.list));
module.exports=router;